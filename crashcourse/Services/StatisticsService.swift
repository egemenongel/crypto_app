//
//  StatisticsService.swift
//  crashcourse
//
//  Created by Egemen Öngel on 21.05.2024.
//

import Foundation
import Combine

class StatisticsService{

    @Published var quote: QuoteModel? = nil

    var statsSubscription: AnyCancellable?

    init(){
        getStatistics()
    }

    private func getStatistics(){
        guard let url = URL(string: "https://sandbox-api.coinmarketcap.com/v1/global-metrics/quotes/latest?convert=BTC,USD")
        else { return }

        var request = URLRequest(url: url)
        request.setValue(String("7cee5147-c18a-4e64-8b54-13d0ba168fd4"), forHTTPHeaderField: "X-CMC_PRO_API_KEY")

        statsSubscription = NetworkingManager.get(urlRequest: request)
            .decode(type: QuoteModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: {[weak self] (returnedQuote) in
                self?.quote = returnedQuote
                self?.statsSubscription?.cancel()
            })
    }
}


