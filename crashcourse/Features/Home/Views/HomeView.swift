//
//  HomeView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 7.10.2023.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = true
    @State private var showPortfolioView: Bool = false
    @State private var showSettingsView: Bool = false

    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView: Bool = false


    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            VStack{
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText:$vm.searchText)
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
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
        .background(
            NavigationLink(
            destination: CoinDetailLoadingView(coin: $selectedCoin),
            isActive: $showDetailView,
            label: {
                EmptyView()
            }
            )
        )
    }
}

extension HomeView {

    private var homeHeader: some View {
        HStack{
            CircleButton(iconName: showPortfolio ? "plus" : "info")
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: 1)
                .background(CircleButtonAnimation(animate: $showPortfolio))
                .onTapGesture {
                    if(showPortfolio){
                        showPortfolioView.toggle()
                    }
                    else{
                        showSettingsView.toggle()
                    }
                }
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
        .sheet(isPresented: $showPortfolioView, content: {
            PortfolioView()
        })
    }

    private var columnTitles: some View{
        HStack{
            HStack{
                Text("Coin")
                    .padding(.leading)

                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
                Spacer()
            }
            .onTapGesture {
                vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
            }


            if showPortfolio{
                HStack{
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))

                }
                .onTapGesture {
                    vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                }
                Spacer()
            }
            HStack{
                HStack{
                    Text("Price")
                        .padding(.leading)
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
                }
                .onTapGesture {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
                Button(action: {
                    withAnimation(.linear(duration: 2.0)){
                    vm.reload()
                }},
                       label: {
                    Image(systemName: "goforward")
                        .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
                })
            }



        }
        .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)
            .frame(alignment: .trailing)
    }

    private var allCoinsList: some View {
        List{
            ForEach(vm.fetchedCoins){
                coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading:0, bottom:10, trailing: 10))
                    .onTapGesture {
                        activateDetail(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }

    private func activateDetail(coin: Coin) {
        selectedCoin = coin
        showDetailView.toggle()
    }

    private var portfolioCoinsList: some View {

        List{
            ForEach(vm.portfolioCoins){
                coin in CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading:0, bottom:10, trailing: 10))
                    .onTapGesture {
                        activateDetail(coin: coin)
                    }
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

