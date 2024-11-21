//
//  City.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import Foundation

struct City {
    
    let id: UUID
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double

    init(
        id: UUID = UUID(),
        name: String,
        country: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }

    init(from response: CityResponse) {
        self.id = UUID()
        self.name = response.name
        self.country = response.country
        self.latitude = response.lat
        self.longitude = response.lon
    }
}

extension City: Identifiable {}

extension City: Codable {}

extension City: Equatable {}

extension City: Hashable {}
