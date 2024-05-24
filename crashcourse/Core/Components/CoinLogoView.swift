//
//  CoinLogoView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 24.05.2024.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: Coin
    var body: some View {
        Text("\(coin.symbol?.first?.description.uppercased() ?? "")")
            .foregroundStyle(Color.theme.accent)
            .background(
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.theme.secondaryText)
            )
            .font(.headline)
            .frame(width: 30)
            .fontWeight(.bold)
    }
}


struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin.data!.first!)
    }
}
