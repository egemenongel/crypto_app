//
//  HomeViewModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 18.11.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    var statistics: [StatisticModel] = []

//    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var fetchedCoins :  [Coin] = []
    @Published var quote : QuoteModel? = nil
    @Published var searchText = ""

    private let dataService = CoinDataService()
    private let statisticsService = StatisticsService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers(){
        getCoins()
        getStatistics()

    }

    private func getCoins(){
        $searchText
                .combineLatest(dataService.$allCoins)
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                .map(filterCoins)
                .sink { [weak self] returnedCoins in
                    self?.fetchedCoins = returnedCoins
                }
                .store(in: &cancellables)
    }

    private func filterCoins(text: String, coinsModel: CoinsModel) -> [Coin]{
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

    private func getStatistics(){
        statisticsService.$quote
            .sink { [weak self] returnedQuote in
                self?.quote = returnedQuote

                // Access data and create statistics inside the closure
                if let data = returnedQuote?.data {
                    let stat = StatisticModel(title: "BTC Dominance", value: data.btcDominance.description)
                    let stat2 = StatisticModel(title: "Active Cryptocurrencies", value: data.activeCryptoCurrencies.description)
                    let stat3 = StatisticModel(title: "Total Exchanges", value: data.totalExchanges.description)
                    let stat4 = StatisticModel(title: "Total Market Cap", value: data.quote.usd.totalMarketCap.description)

                    self?.statistics.append(contentsOf: [stat, stat2, stat3, stat4])
                }
            }
            .store(in: &cancellables)
    }

//    func addFakeData(){
//        //Add fake data
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.allCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
//            self.portfolioCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
//        }
//    }


}
