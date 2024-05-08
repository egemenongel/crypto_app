//
//  NetworkingManager.swift
//  crashcourse
//
//  Created by Egemen Öngel on 8.05.2024.
//

import Foundation
import Combine

class NetworkingManager{

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

     static func download(urlRequest: URLRequest)-> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse(output: $0,url: urlRequest.url!)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        let response = output.response as? HTTPURLResponse
       if(response!.statusCode >= 200 && response!.statusCode < 300)
       {
           print(response.debugDescription)
       }
       else{
           print(response?.statusCode)
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
}
