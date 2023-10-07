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
        
    let coin = CoinModel(id: 1, name: "example", symbol: "EXP", slug: "slug", cmcRank: 0, currentHoldings: 1.5)
}
