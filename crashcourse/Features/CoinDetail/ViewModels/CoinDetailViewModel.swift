//
//  CoinDetailViewModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 23.05.2024.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    var statistics: [StatisticModel] = []


    init(coin: Coin){
        setStats(coin: coin)
    }

    func setStats(coin: Coin){
        let stat1 = StatisticModel(title: "Market Cap", value: coin.marketCap.asCurrencyWith2Decimals())
        let stat2 = StatisticModel(title: "Price", value: coin.currentPrice.asCurrencyWith2Decimals())
        let stat3 = StatisticModel(title: "Rank", value: (coin.cmcRank ?? 0).description)
        let stat4 = StatisticModel(title: "Percent Change", value: "\(coin.percentChange.doubleWith2Decimal())%")
        statistics.append(contentsOf: [stat1, stat2, stat3, stat4])
    }
}
