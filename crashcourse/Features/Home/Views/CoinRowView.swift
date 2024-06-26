//
//  CoinRowView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let showHoldingsColumn: Bool
    var body: some View {
        HStack(spacing: 0){
            leftColumn
            if showHoldingsColumn {
            centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .padding(.horizontal,10)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }

    private var leftColumn: some View{

        HStack(spacing: 0){
            Text("\(coin.cmcRank!)")
                .frame(width: 70)
            CoinLogoView(coin: coin)
            Spacer()
            Text((coin.first3Letter.uppercased()))
                .font(.caption)
                .foregroundStyle(Color.theme.accent)
            Spacer()

        }
    }
    
    private var centerColumn: some View{
        VStack{
            Text(coin.currentHoldings!.description)
            Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                .font(.caption)
        }
        .frame(width:70)
    }
    
    private var rightColumn: some View{
        VStack(alignment: .trailing){
            Text("\(coin.quote?.usd?.price ?? 0)")
            Text("\(coin.quote?.usd?.percentChange24H ?? 0)").foregroundStyle(
                1>0 ?
                Color.theme.green :
                Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 5, alignment:  .trailing)
        .padding()
    }
}



struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View{
        CoinRowView(coin: dev.coin.data!.first!, showHoldingsColumn: true)
    }
}
