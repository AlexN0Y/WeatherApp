//
//  ContentView.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State private var showWeatherDetail = false
    
    var body: some View {
        NavigationStack {
            VStack {
                searchBar
                
                if viewModel.isLoading {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else if !viewModel.searchResults.isEmpty {
                    searchResultsList
                } else {
                    popularAndFavoriteCitiesList
                }
            }
            .navigationTitle("Weather App")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HistoryView()) {
                        Text("History")
                    }
                }
            }
            .navigationDestination(for: City.self) { city in
                let weatherDetailsViewModel = WeatherDetailsViewModel(city: city)
                WeatherDetailsView(viewModel: weatherDetailsViewModel)
            }
            .onAppear {
                viewModel.loadFavoriteCities()
            }
        }
    }
}

private extension ContentView {
    
    var searchBar: some View {
        TextField("Search for a city", text: $viewModel.searchQuery)
            .textFieldStyle(.roundedBorder)
            .overlay {
                if !viewModel.searchQuery.isEmpty {
                    clearButton
                }
            }
            .padding()
    }
    
    var clearButton: some View {
        HStack {
            Spacer()
            Button(action: viewModel.clearSearchQuery){
                Image(systemName: "xmark")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(.gray.opacity(0.9))
            }
            .foregroundColor(.secondary)
            .padding(.trailing, 4)
        }
    }
    
    var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var searchResultsList: some View {
        List(viewModel.searchResults) { city in
            NavigationLink(value: city) {
                VStack(alignment: .leading) {
                    Text("\(city.name), \(city.country)")
                        .font(.headline)
                }
            }
        }
    }
    
    var popularAndFavoriteCitiesList: some View {
        List {
            popularCitiesSection
            favoriteCitiesSection
        }
        .listStyle(.insetGrouped)
    }
    
    var popularCitiesSection: some View {
        Section(header: Text("Popular Cities")) {
            ForEach(viewModel.popularCities) { city in
                NavigationLink(value: city) {
                    Text(city.name)
                }
            }
        }
    }
    
    var favoriteCitiesSection: some View {
        Section(header: Text("Favorite Cities")) {
            ForEach(viewModel.favoriteCities) { city in
                NavigationLink(value: city) {
                    Text(city.name)
                }
            }
            .onDelete { offsets in
                viewModel.removeCityFromFavorites(at: offsets)
            }
        }
    }
}

private extension ContentView {
    
    func errorView(message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
