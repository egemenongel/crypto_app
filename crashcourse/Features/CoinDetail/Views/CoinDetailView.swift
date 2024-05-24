//
//  CoinDetailView.swift
//  crashcourse
//
//  Created by Egemen Öngel on 23.05.2024.
//

import SwiftUI

struct CoinDetailLoadingView: View {
    @Binding var coin: Coin?
    @State private var showFullDescription: Bool = false
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
    @State private var showFullDescription: Bool = false
    private let gridColumns = [GridItem(.flexible()),GridItem(.flexible())]

    let coin: Coin

    init(coin: Coin){
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack {
                    overviewTitle
                    description
                    statsGrid
            }
        }
        .navigationTitle(coin.symbol?.capitalized ?? "")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                HStack{
                    Text(coin.first3Letter.uppercased())
                        .padding()
                    CoinLogoView(coin: coin)
                }
            }
        }
    }
}

extension CoinDetailView {
    
    private var description: some View {
        VStack{
            Text(
    """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel dui nibh. Donec dapibus at turpis vel porttitor. Donec ut velit faucibus, ultrices dolor nec, fermentum dui. Nunc pulvinar nulla vitae lacus ornare, ut fringilla enim fringilla. Nulla ut gravida tortor. Maecenas dignissim est vel tortor tempor, sed blandit dolor condimentum. Maecenas tempus sed velit at fermentum. Suspendisse eget porta elit, sed condimentum augue. Nulla a metus vehicula, pretium nibh in, malesuada eros. Aenean eu posuere orci. Integer mollis felis quis massa bibendum pellentesque vitae in diam. Nam in velit ut justo condimentum iaculis a nec diam. Vestibulum at dui cursus, accumsan turpis ac, porta turpis. Nunc dictum rhoncus interdum.

    Vivamus maximus turpis id leo fermentum suscipit. Vestibulum ac lacus non tellus faucibus venenatis. Duis ornare sapien nec ipsum rutrum, non fermentum libero consequat. Donec molestie erat at fermentum lacinia. Duis semper aliquet elit, sit amet tristique neque efficitur non. Vestibulum varius est risus, id blandit lacus ultricies sit amet. Vivamus in est rhoncus, scelerisque eros eget, facilisis urna. Cras nec ornare nunc. Maecenas vulputate velit non mauris mattis, vitae vehicula nunc tempor. Sed eros enim, vulputate sit amet facilisis vitae, finibus ut enim. Vivamus placerat finibus cursus. Aliquam massa enim, mattis ac felis at, dignissim mollis leo. Vestibulum sit amet ligula ante. Mauris eget fermentum diam, vitae volutpat leo.

    Integer dapibus non elit ut lacinia. Etiam tincidunt mi ac viverra aliquam. Maecenas nec turpis iaculis, maximus turpis vitae, lacinia quam. Vivamus eros ex, feugiat vitae molestie vel, finibus ac augue. Integer maximus condimentum dui et efficitur. Mauris volutpat tempor lectus ut bibendum. Fusce nec augue at sapien volutpat tincidunt. Donec vel dui et tellus sagittis pellentesque. Donec at sollicitudin lorem. Pellentesque posuere mauris eu ipsum maximus porttitor. Praesent suscipit neque nisi, venenatis iaculis mauris aliquet tempus. Suspendisse iaculis, urna id gravida placerat, lectus leo malesuada eros, vitae pretium orci turpis in lectus. Praesent mattis tincidunt pulvinar. Proin vestibulum imperdiet sapien, vel sodales sem iaculis in. Aenean ullamcorper scelerisque dui eget mattis. Nullam rutrum metus et odio interdum, vehicula malesuada urna rhoncus.

    Maecenas ac tristique lacus. Quisque iaculis aliquet enim vitae malesuada. Nullam suscipit urna dolor, ac posuere ante consectetur sit amet. Vestibulum sit amet luctus dolor, a cursus mauris. Phasellus eleifend nisi ac purus cursus tincidunt. Sed non felis enim. Suspendisse consectetur eu enim ac placerat. Duis cursus felis nec orci egestas, ac sagittis metus maximus. Ut in leo eget sapien condimentum porta. Aliquam interdum lacinia turpis, at ultrices urna accumsan et. Vestibulum pharetra purus ac ipsum maximus venenatis. Quisque ut sem nec ligula ultrices rutrum. Duis pharetra nunc eu sapien pulvinar, id auctor felis mattis.

    """
            )
            .font(.callout)
            .foregroundStyle(Color.theme.secondaryText)
            .lineLimit(showFullDescription ? nil : 3)
            .padding()
            if (!showFullDescription){
                VStack(alignment: .leading) {
                    Button("Read more...", action: {showFullDescription.toggle()})
                        .foregroundStyle(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            }
        }
    }

    private var overviewTitle: some View {
        VStack{
            Text("Overview")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            Divider()
        }
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

