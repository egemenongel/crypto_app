//
//  CoinRowView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
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
    }
    
    private var leftColumn: some View{
        HStack(spacing: 0){
            Text("\(coin.cmcRank!)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
            Spacer()
        }
    }
    
    private var centerColumn: some View{
        VStack{
            Text("$ \(coin.currentHoldings!)")
            Text("\(coin.currentHoldings!)")
        }
    }
    
    private var rightColumn: some View{
        VStack(alignment: .trailing){
            Text("$123,408.00")
            Text("3.12 %").foregroundStyle(
                1>0 ?
                Color.theme.green :
                Color.theme.red)
        }.frame(width: UIScreen.main.bounds.width / 3, alignment:  .trailing)
    }
}



struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View{
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
    }
}
