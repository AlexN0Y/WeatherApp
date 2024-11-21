//
//  WeatherDetailsView.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import SwiftUI

struct WeatherDetailsView: View {
    
    @StateObject var viewModel: WeatherDetailsViewModel
    
    var body: some View {
        VStack {
            if let weather = viewModel.weather {
                weatherInfo(weather: weather)
                imageView
                favoriteButton
            } else {
                ProgressView("Loading weather...")
            }
        }
        .navigationTitle("Weather Details")
        .task {
            await viewModel.fetchWeatherAndCatImage()
        }
    }
}

private extension WeatherDetailsView {
    
    @ViewBuilder
    var imageView: some View {
        if let image = viewModel.catImage {
            Image(uiImage: image)
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(10)
        } else {
            ProgressView("The cat's coming...")
                .frame(width: 200, height: 200)
        }
    }
    
    var favoriteButton: some View {
        Button(action: {
            viewModel.toggleFavoriteStatus()
        }) {
            Text(viewModel.favoriteButtonText)
                .foregroundStyle(.white)
                .padding(.vertical, 4)
                .padding(.horizontal)
                .background(viewModel.isFavorite ? Color.red : Color.blue)
                .clipShape(.rect(cornerRadius: 6))
        }
        .padding()
    }
}

private extension WeatherDetailsView {
    
    func weatherInfo(weather: Weather) -> some View {
        Group {
            Text(weather.cityName)
                .font(.largeTitle)
            Text("\(weather.temperature, specifier: "%.1f")°C")
                .font(.title)
            Text(weather.description.capitalized)
                .font(.subheadline)
        }
    }
}

#Preview {
    WeatherDetailsView(viewModel: WeatherDetailsViewModel(city: MockedCities.london.city))
}
