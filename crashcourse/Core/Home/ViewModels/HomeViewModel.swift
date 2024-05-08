//
//  HomeViewModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 18.11.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var fetchedCoins :  [Coin] = []
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        //Add fake data
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.allCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
            self.portfolioCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
        }

        dataService.$allCoins
            .sink{[weak self] (returnedCoins) in
                self?.fetchedCoins = returnedCoins.data!
            }
            .store(in: &cancellables)
    }
}
