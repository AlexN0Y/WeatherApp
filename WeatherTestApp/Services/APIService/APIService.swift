//
//  APIService.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import Foundation

struct APIService {
    
    private let weatherAPIKey = "8ec9e732ed89827a684cd1140f32768e"
}

extension APIService {
    
    func searchCities(query: String) async throws -> [City] {
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "http://api.openweathermap.org/geo/1.0/direct?q=\(queryEncoded)&limit=5&appid=\(weatherAPIKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let cityResponses = try JSONDecoder().decode([CityResponse].self, from: data)
        return cityResponses.map { City(from: $0) }
    }

    func fetchWeather(lat: Double, lon: Double) async throws -> Weather {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(weatherAPIKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return Weather(
            cityName: weatherResponse.name,
            temperature: weatherResponse.main.temp,
            description: weatherResponse.weather.first?.description ?? ""
        )
    }

    func fetchRandomCatImage() async throws -> CatImage {
        let jsonURLString = "https://cataas.com/cat?json=true"
        
        guard let jsonURL = URL(string: jsonURLString) else {
            throw URLError(.badURL)
        }

        let (jsonData, _) = try await URLSession.shared.data(from: jsonURL)

        let decoder = JSONDecoder()
        let catImageResponse = try decoder.decode(CatImageResponse.self, from: jsonData)

        let context = PersistenceController.shared.managedObjectContext
        let catImage = CatImage(context: context)
        catImage.id = catImageResponse._id
        catImage.viewedAt = Date.now

        let imageURLString = "https://cataas.com/cat/\(catImageResponse._id)"
        guard let imageURL = URL(string: imageURLString) else {
            throw URLError(.badURL)
        }

        let (imageData, _) = try await URLSession.shared.data(from: imageURL)

        catImage.imageData = imageData
        
        PersistenceController.shared.saveContext()
        
        return catImage
    }
}

