//
//  PreviewProvider.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//

import Foundation
import SwiftUI

extension PreviewProvider{
    
    static var dev: DeveloperPreview{
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview{
    
    static let instance = DeveloperPreview()
    private init() { }
        
    let homeVM = HomeViewModel()
    
    let stat1 = StatisticModel(title: "Market Cap", value: 125663, percentageChange: 25.34)
    let stat2 = StatisticModel(title: "Total Volume", value: 1.23)
    let stat3 = StatisticModel(title: "Portfolio Value", value: 50.4, percentageChange: -22.32)
    let coin = CoinsModel(data: [Coin(id: 1,cmcRank: 0, name: "example", symbol: "EXAMPLECOIN", slug: "slug", currentHoldings: 500,quote: Quote(usd: USD(price: 90, percentChange24H: 10, marketCap: 500)))])
}
