//
//  ContentViewModel.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import SwiftUI
import Combine

@MainActor
final class ContentViewModel: ObservableObject {
    
    @Published var popularCities = MockedCities.allCases.map { $0.city }
    @Published var favoriteCities = [City]()
    @Published var searchQuery = ""
    @Published var searchResults = [City]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService()
    private let favoritesService = FavoritesService()
    
    init() {
        configureBindings()
    }
}

extension ContentViewModel {
    
    func loadFavoriteCities() {
        favoriteCities = favoritesService.loadFavoriteCities()
    }
    
    func removeCityFromFavorites(at offsets: IndexSet) {
        for index in offsets {
            let city = favoriteCities[index]
            favoritesService.removeCityFromFavorites(city)
        }
        
        loadFavoriteCities()
    }
    
    func searchCities(for newQuery: String) async {
        guard !newQuery.isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let results = try await apiService.searchCities(query: newQuery)
            searchResults = results
        } catch {
            errorMessage = "Failed to load search results: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func clearSearchQuery() {
        searchQuery = ""
    }
}

private extension ContentViewModel {
    
    func configureBindings() {
        $searchQuery
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] newQuery in
                Task {
                    await self?.searchCities(for: newQuery)
                }
            }
            .store(in: &cancellables)
    }
}
