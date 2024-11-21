//
//  WeatherDetailsViewModel.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import SwiftUI

@MainActor
final class WeatherDetailsViewModel: ObservableObject {
    
    @Published private(set) var weather: Weather?
    @Published private(set) var catImage: UIImage?
    @Published private(set) var isFavorite: Bool = false
    
    var favoriteButtonText: String {
        isFavorite ? "Remove from Favorites" : "Add to Favorites"
    }

    private let apiService = APIService()
    private let historyService = HistoryService()
    private let favoritesService = FavoritesService()
    private let city: City

    init(city: City) {
        self.city = city
        self.isFavorite = favoritesService.isCityFavorite(city)
    }
}

extension WeatherDetailsViewModel {
    
    func fetchWeatherAndCatImage() async {
        do {
            weather = try await apiService.fetchWeather(lat: city.latitude, lon: city.longitude)
            try await fetchRandomCatImage()
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func toggleFavoriteStatus() {
        isFavorite ? favoritesService.removeCityFromFavorites(city)
        : favoritesService.addCityToFavorites(city)
        
        isFavorite.toggle()
    }
}

private extension WeatherDetailsViewModel {
    
    func fetchRandomCatImage() async throws {
        let catImage = try await apiService.fetchRandomCatImage()

        if let data = catImage.imageData,
           let image = UIImage(data: data) {
            self.catImage = image
            historyService.saveCatImage()
        }
    }
}
