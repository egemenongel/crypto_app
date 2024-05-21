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

    @Published var searchText = ""
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }
    
//    func addFakeData(){
//        //Add fake data
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.allCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
//            self.portfolioCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
//        }
//    }

    func addSubscribers(){

        $searchText
                .combineLatest(dataService.$allCoins)
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                .map(filterCoins)
                .sink { [weak self] returnedCoins in
                    self?.fetchedCoins = returnedCoins
                }
                .store(in: &cancellables)

    }

    func filterCoins(text: String, coinsModel: CoinsModel) -> [Coin]{
        guard let coins = coinsModel.data else {
            return []
        }

        guard !text.isEmpty else {
            return coins
        }

        let lowercasedText = text.lowercased()

        return coins.filter { coin in
            return coin.name?.lowercased().contains(lowercasedText) == true ||
                   coin.symbol?.lowercased().contains(lowercasedText) == true
        }
    }
}
