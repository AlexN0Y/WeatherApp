//
//  HistoryViewModel.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import SwiftUI

final class HistoryViewModel: ObservableObject {
    
    @Published private(set) var catImageHistory: [CatImage] = []

    private let historyService = HistoryService()

    init() {
        loadCatImageHistory()
    }
}

private extension HistoryViewModel {
    
    func loadCatImageHistory() {
        catImageHistory = historyService.fetchCatImageHistory()
    }
}
