//
//  City.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import Foundation

struct City {
    
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    var id: String {
        "\(longitude),\(latitude)"
    }

    init(
        name: String,
        country: String,
        latitude: Double,
        longitude: Double
    ) {
        self.name = name
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension City: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case name, country
        case latitude = "lat"
        case longitude = "lon"
    }
}

extension City: Identifiable {}

extension City: Equatable {}

extension City: Hashable {}
