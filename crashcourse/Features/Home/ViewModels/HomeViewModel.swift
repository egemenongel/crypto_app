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
    @Published var isLoading = false

    private let dataService = CoinDataService()
    private let statisticsService = StatisticsService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func addSubscribers(){
        getCoins()
        getPortfolio()
        getStatistics()
    }

    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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

    private func getPortfolio(){
        $fetchedCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [Coin] in

                coinModels.compactMap{(coin) -> Coin? in
                    guard let entity = portfolioEntities.first(where: { $0.coinId == coin.coinId}) else {
                        return nil
                }
                    return coin.updateHoldings(amount: entity.amount)
            }
            }
            .sink{[weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins}
            .store(in: &cancellables)
    }

    private func getStatistics(){
        statisticsService.$quote
            .combineLatest($portfolioCoins)
            .sink { [weak self] returnedQuote,returnedPortfolio in
                self?.quote = returnedQuote


                let portfolioValue = returnedPortfolio
                    .map { (coin)-> Double in
                    return coin.currentHoldingsValue
                    }
                    .reduce(0, +)

                let previousValue = returnedPortfolio
                    .map { (coin) -> Double in
                        let currentValue = coin.currentHoldingsValue
                        let percentChange = (coin.quote?.usd?.percentChange24H ?? 0) / 100
                        let previousValue = currentValue / (1 + percentChange)
                        return previousValue
                    }
                    .reduce(0,+)

                let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100


                // Access data and create statistics inside the closure
                if let data = returnedQuote?.data {
                    let stat = StatisticModel(title: "BTC Dominance", value: data.btcDominance.description)
                    let stat2 = StatisticModel(title: "Total Exchanges", value: data.totalExchanges.description)
                    let stat3 = StatisticModel(title: "Total Market Cap", value: data.quote.usd.totalMarketCap.description)
                    let stat4 = StatisticModel(title: "Portfolio Value", value: "$\(portfolioValue)", percentageChange: percentageChange.isNaN ? 0 : percentageChange)
                    self?.statistics.append(contentsOf: [stat, stat2, stat3, stat4])
                }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }

    func reload (){
        isLoading = true
        dataService.getCoins()
        statisticsService.getStatistics()
        HapticManager.notification(type: .success)
    }

//    func addFakeData(){
//        //Add fake data
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.allCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
//            self.portfolioCoins.append(contentsOf: DeveloperPreview.instance.coin.data ?? [])
//        }
//    }


}
