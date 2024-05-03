//
//  HomeViewModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 18.11.2023.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []

    init() {
        //Add fake data
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.allCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
            self.portfolioCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
        }
    }
}
