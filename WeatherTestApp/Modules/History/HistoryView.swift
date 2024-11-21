//
//  HistoryView.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 19.11.2024.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject private var viewModel = HistoryViewModel()

    var body: some View {
        List(viewModel.catImageHistory, id: \.self) { catImage in
            historyCell(for: catImage)
        }
        .navigationTitle("Cat Image History")
    }
}

private extension HistoryView {
    
    @ViewBuilder
    func historyCell(for catImage: CatImage) -> some View {
        if let imageData = catImage.imageData,
           let image = UIImage(data: imageData) {
            HStack {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    if let viewedAt = catImage.viewedAt {
                        Text(viewedAt, style: .date)
                    }
                    
                    Text(catImage.id ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
