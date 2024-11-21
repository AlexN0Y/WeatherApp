//
//  MockedCities.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 20.11.2024.
//

import Foundation

enum MockedCities: CaseIterable {
    
    case london
    case tokyo
    case newYork

    var city: City {
        switch self {
        case .london:
            City(name: "London", country: "GB", latitude: 51.5074, longitude: -0.1278)
        case .tokyo:
            City(name: "Tokyo", country: "JP", latitude: 35.6895, longitude: 139.6917)
        case .newYork:
            City(name: "New York", country: "US", latitude: 40.7128, longitude: -74.0060)
        }
    }
}

