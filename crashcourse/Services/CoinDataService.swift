//
//  CoinDataService.swift
//  crashcourse
//
//  Created by Egemen Öngel on 3.05.2024.
//

import Foundation
import Combine

class CoinDataService{

    @Published var allCoins: CoinsModel = CoinsModel(data: [])

    var coinSubscription: AnyCancellable?
    init(){
        getCoins()
    }

    private func getCoins(){
        guard let url = URL(string: "https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100&sort=market_cap&cryptocurrency_type=all&tag=all")
        else { return }


        var request = URLRequest(url: url)
        request.setValue(String("7cee5147-c18a-4e64-8b54-13d0ba168fd4"), forHTTPHeaderField: "X-CMC_PRO_API_KEY")

        coinSubscription = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap{(output) -> Data in
                 let response = output.response as? HTTPURLResponse
                if(             response!.statusCode >= 200 && response!.statusCode < 300)
                {

                } 
                else{
                    print(response?.statusCode)
                    throw URLError(.badServerResponse)

                }

                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: CoinsModel.self, decoder: JSONDecoder())
            .sink{ (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] (returnedCoins) in
                      self?.allCoins = returnedCoins
                      self?.coinSubscription?.cancel()
            }

    }
}
