//
//  CityResponse.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 20.11.2024.
//

import Foundation

struct CityResponse: Codable {
    
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}
