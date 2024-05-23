//
//  CoinDetailView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 23.05.2024.
//

import SwiftUI

struct CoinDetailLoadingView: View {
    @Binding var coin: Coin?

    var body: some View {
        ZStack{
            if let coin = coin {
                CoinDetailView(coin: coin)
            }
        }
    }
}

struct CoinDetailView: View {
    @StateObject private var vm: CoinDetailViewModel

    private let gridColumns = [GridItem(.flexible()),GridItem(.flexible())]

    let coin: Coin

    init(coin: Coin){
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack {
                    descriptionText
                    overviewTitle
                    statsGrid
            }
        }
        .navigationTitle(coin.symbol?.capitalized ?? "")
    }
}

extension CoinDetailView {
    
    private var descriptionText: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam feugiat tristique justo, eu porta nunc finibus cursus. Aliquam at tincidunt erat. Mauris et quam sit amet enim blandit bibendum vel ac turpis. Nunc suscipit tincidunt aliquet.")
            .padding()
    }

    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
    }

    private var statsGrid: some View {
        LazyVGrid(
            columns: gridColumns,
            alignment: .leading,
            spacing: 10
        ) {
            ForEach(vm.statistics) {
                stat in
                StatisticView(stat: stat)
            }
        }
        .padding()
    }
}


struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CoinDetailView(coin:dev.coin.data!.first!)
        }
    }
}

