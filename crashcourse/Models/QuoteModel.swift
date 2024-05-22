//
//  QuoteModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import Foundation

struct QuoteModel: Codable{
    let data: DataModel
}

struct DataModel: Codable{
    let activeCryptoCurrencies: Int
    let totalExchanges: Int
    let btcDominance: Double
    let quote: Quote2


    enum CodingKeys: String, CodingKey {
        case activeCryptoCurrencies = "active_cryptocurrencies"
        case totalExchanges = "total_exchanges"
        case btcDominance = "btc_dominance"
        case quote
    }
}

struct Quote2: Codable{
    let usd: USDModel

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

struct USDModel: Codable{
    let totalMarketCap : Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
    }
}

