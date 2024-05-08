//
//  NetworkingManager.swift
//  crashcourse
//
//  Created by Egemen Öngel on 8.05.2024.
//

import Foundation
import Combine

class NetworkingManager{

    static func get(urlRequest: URLRequest)-> AnyPublisher<Data, Error> {
    return URLSession.shared.dataTaskPublisher(for: urlRequest)
        .subscribe(on: DispatchQueue.global(qos: .default))
        .tryMap({try handleURLResponse(output: $0,url: urlRequest.url!)})
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,response.statusCode >= 200 && response.statusCode < 300
                else
        {
            throw NetworkingError.badURLResponse(url: url)
        }
       return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error> ){
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    enum NetworkingError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown

        var errorDescription: String?{
            switch self {
            case .badURLResponse(url: let url): return  "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
}
