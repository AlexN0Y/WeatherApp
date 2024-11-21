//
//  FavoritesService.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import CoreData

struct FavoritesService {
    
    private let persistenceController = PersistenceController.shared
}

extension FavoritesService {
    
    func loadFavoriteCities() -> [City] {
        persistenceController.loadFavoriteCities()
    }
    
    func saveFavoriteCities(_ cities: [City]) {
        persistenceController.saveFavoriteCities(cities)
    }
    
    func addCityToFavorites(_ city: City) {
        var favoriteCities = loadFavoriteCities()
        if !favoriteCities.contains(city) {
            favoriteCities.append(city)
            saveFavoriteCities(favoriteCities)
        }
    }
    
    func removeCityFromFavorites(_ city: City) {
        var favoriteCities = loadFavoriteCities()
        favoriteCities.removeAll { $0 == city }
        saveFavoriteCities(favoriteCities)
    }
    
    func isCityFavorite(_ city: City) -> Bool {
        loadFavoriteCities().contains(city)
    }
}
