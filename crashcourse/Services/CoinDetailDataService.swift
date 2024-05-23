//
//  CoinDataService.swift
//  crashcourse
//
//  Created by Egemen Öngel on 3.05.2024.
//

import Foundation
import Combine

class CoinDetailDataService{

    @Published var coinDetail: CoinDetailModel? = nil
    let coin: Coin

    var coinDetailSubscription: AnyCancellable?

    init(coin: Coin){
        self.coin = coin
//        getDetail()
    }
    // Not working just example
    func getDetail(){

        guard let url = URL(string: "https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/\(coin.id)")
        else { return }

        var request = URLRequest(url: url)
        request.setValue(String("7cee5147-c18a-4e64-8b54-13d0ba168fd4"), forHTTPHeaderField: "X-CMC_PRO_API_KEY")

        coinDetailSubscription = NetworkingManager.get(urlRequest: request)
            .decode(type:CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: {[weak self] (returnedDetail) in
                self?.coinDetail = returnedDetail
                self?.coinDetailSubscription?.cancel()
            })
    }
}
