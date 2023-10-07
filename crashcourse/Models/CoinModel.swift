//
//  CoinModel.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//
//   let coinModel = try? JSONDecoder().decode(CoinModel.self, from: jsonData)

import Foundation

// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    let id: Int
    let name, symbol, slug: String
    let cmcRank: Int?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case cmcRank = "cmc_rank"
        case currentHoldings
    }
    
    func updateHoldings (amount: Double) -> CoinModel{
        return CoinModel(id: id, name: name, symbol: symbol, slug: slug, cmcRank: cmcRank, currentHoldings: amount)
    }
   
}
