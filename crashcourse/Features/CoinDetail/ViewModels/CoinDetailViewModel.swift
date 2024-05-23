//
//  CoinDetailViewModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 23.05.2024.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {

    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    var statistics: [StatisticModel] = []


    init(coin: Coin){
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
        setStats(coin: coin)
    }
    
    func setStats(coin: Coin?){
        if(coin != nil){
            let stat1 = StatisticModel(title: "Market Cap", value: coin!.marketCap.asCurrencyWith2Decimals())
            let stat2 = StatisticModel(title: "Price", value: coin!.currentPrice.asCurrencyWith2Decimals())
            let stat3 = StatisticModel(title: "Rank", value: (coin!.cmcRank ?? 0).description)
            let stat4 = StatisticModel(title: "Percent Change", value: "\(coin!.percentChange.doubleWith2Decimal())%")
            statistics.append(contentsOf: [stat1, stat2, stat3, stat4])
        }
    }

    private func addSubscribers() {
        coinDetailService.$coinDetail
            .sink { (returnedDetails) in
                print ("Received Coin Data")
            }
            .store(in: &cancellables)
    }
}
