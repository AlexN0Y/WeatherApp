//
//  WeatherResponse.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import Foundation

struct WeatherResponse: Codable {
    
    let name: String
    let main: Main
    let weather: [WeatherDetail]

    struct Main: Codable {
        let temp: Double
    }

    struct WeatherDetail: Codable {
        let description: String
    }
}
