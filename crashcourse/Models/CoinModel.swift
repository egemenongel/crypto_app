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

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case cmcRank = "cmc_rank"
        case currentHoldings
    }

    func updateHoldings (amount: Double) -> Coin{
        return Coin(id: id, cmcRank: cmcRank, name: name, symbol: symbol, slug: slug, currentHoldings: amount)
    }
}

