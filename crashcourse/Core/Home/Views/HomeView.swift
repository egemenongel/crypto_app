//
//  HomeView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack{
                homeHeader
                columnTitles
                
                if !showPortfolio{
                allCoinsList
                .transition(.move(edge: .leading))
                }
                if showPortfolio{
                portfolioCoinsList
                .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}


extension HomeView {

    private var homeHeader: some View {
        VStack{
            HStack{
                CircleButton(iconName: showPortfolio ? "plus" : "info")
                    .animation(.none)
                    .background(CircleButtonAnimation(animate: $showPortfolio))
                Spacer()
                Text(showPortfolio ? "Portfolio" : "Live Prices")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.theme.accent)
                Spacer()
                CircleButton(iconName: "chevron.right")
                    .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()){
                            showPortfolio.toggle()
                        }
                    }
            }
            .padding(.horizontal)

        }
    }

    private var columnTitles: some View{
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings")
                Spacer()
            }
            Text("Price")
        }
        .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
    }

    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins){
                coin in CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading:0, bottom:10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins){
                coin in CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading:0, bottom:10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView().toolbar(.hidden)
        }
        .environmentObject(dev.homeVM)
    }
}

