//
//  HistoryViewModel.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    
    @Published var catImageHistory: [CatImage] = []

    private let historyService = HistoryService()

    init() {
        loadCatImageHistory()
    }

    func loadCatImageHistory() {
        catImageHistory = historyService.fetchCatImageHistory()
    }
}
