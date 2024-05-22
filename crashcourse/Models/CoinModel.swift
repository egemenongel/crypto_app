//
//  CoinModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//
//   let coinModel = try? JSONDecoder().decode(CoinModel.self, from: jsonData)

import Foundation

// MARK: - CoinModel
struct CoinsModel: Codable{
    let data: [Coin]?
}

// MARK: - Datum
struct Coin: Identifiable, Codable{
    let id, cmcRank: Int?
    let name, symbol, slug: String?
    let currentHoldings: Double?
    let quote: Quote?
    let coinId: String = UUID().uuidString

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug, quote, coinId
        case cmcRank = "cmc_rank"
        case currentHoldings
    }
    
    func updateHoldings (amount: Double) -> Coin{
        return Coin(id: id, cmcRank: cmcRank, name: name, symbol: symbol, slug: slug, currentHoldings: amount, quote: quote)
    }

    var currentPrice: Double{
        return quote?.usd?.price ?? 0
    }

    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
}
struct Quote: Codable{
    let usd: USD?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }

}

struct USD: Codable{
    let price: Double?
    let percentChange24H: Double?

    enum CodingKeys: String, CodingKey {
        case price
        case percentChange24H = "percent_change_24h"
    }
}

