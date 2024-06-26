//
//  PortfolioView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var ownedText: String = ""
    @State private var showCheckmark: Bool = false
    var body: some View {
        NavigationStack{
            if #available(iOS 17.0, *) {
                ScrollView{
                    VStack(alignment: .leading, spacing:10){
                        SearchBarView(searchText: $vm.searchText)
                        coinsList
                        if(selectedCoin != nil){
                            editPortfolioSection
                        }
                    }
                }
                .navigationTitle("Edit Portfolio")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        CloseButton()
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        trailingNavButtons
                    }
                }
                .onChange(of: vm.searchText) { oldValue, newValue in
                    if newValue == ""{
                        removeSelectedCoin()
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }

    }

    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin

        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            ownedText = "\(amount)"
        } else {
            ownedText = ""
        }
    }

    private func totalValue() -> Double{
        if let quantity = Double(ownedText){
            return quantity * (selectedCoin?.quote?.usd?.price ?? 0)
        }

        return 0
    }
}



extension PortfolioView {
    var coinsList: some View{
        ScrollView(.horizontal,showsIndicators: false, content: {
            LazyHStack{
                ForEach(vm.fetchedCoins){ coin in
                    VStack(spacing: 0){
                        Spacer()
                        CoinLogoView(coin: coin)
                        Text(coin.first3Letter)
                            .padding(30)

                    }
                    
                    .background(
                        RoundedRectangle(cornerRadius:8)
                            .stroke(coin.id == selectedCoin?.id ? Color.theme.green : Color.clear)

                    ).onTapGesture {
                        withAnimation(.easeIn){
                       updateSelectedCoin(coin: coin)
                        }

                    }
                    .foregroundStyle(Color.theme.accent)

                }

            }
        })
    }

    var editPortfolioSection: some View{
        VStack(alignment: .leading, spacing:20){
            HStack{
                Text("Current price of \(selectedCoin!.symbol ?? ""):")
                Spacer()
                Text(selectedCoin?.quote?.usd?.price?.asCurrencyWith6Decimals() ?? "")
            }
            .padding(.leading)
            Divider()
            HStack{
                Text("Owned: ")
                Spacer()
                TextField("", text: $ownedText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            .padding(.leading)
            Divider()
            HStack{
                Text("Current value: ")
                Spacer()
                Text("\(totalValue().asCurrencyWith2Decimals())")
            }
            .padding(.leading)
        }
    }

    var trailingNavButtons: some View{
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0 )
            Button(action:
                    saveButtonPressed
                   , label: {
                Text("SAVE")
            })
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(ownedText)) ? 1.0 : 0.0)

        }
    }

    private func saveButtonPressed(){

        // Save to Portfolio
        let coin = selectedCoin
        let amount = Double(ownedText)

        if(coin != nil && amount != nil){
            vm.updatePortfolio(coin: coin!, amount: amount!)
        }


        // Show Checkmark
        withAnimation(.easeIn){
            showCheckmark.toggle()
            removeSelectedCoin()
        }

        UIApplication.shared.endEditing()

        // Hide Checkmark

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut){
                showCheckmark.toggle()
            }
        }
    }

    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}



struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View{
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}




