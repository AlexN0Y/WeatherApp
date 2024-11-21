//
//  HistoryService.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 20.11.2024.
//

import Foundation

struct HistoryService {
    
    private let persistenceController = PersistenceController.shared
}

extension HistoryService {
    
    func saveCatImage() {
        persistenceController.saveContext()
    }

    func fetchCatImageHistory() -> [CatImage] {
        persistenceController.fetchCatImageHistory()
    }
}
