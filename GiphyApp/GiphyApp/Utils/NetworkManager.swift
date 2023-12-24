//
//  NetworkManager.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import Foundation
import Combine


protocol NetworkManagerProtocol {
    static func fetchData<T: Codable>(using apiUrl: String) -> AnyPublisher<T, NetworkError>
}

class NetworkManager: NetworkManagerProtocol {
    
    static func fetchData<T: Codable>(using apiUrl: String) -> AnyPublisher<T, NetworkError> {
        
        guard let url = URL(string: apiUrl) else {
            return Fail(error: NetworkError.InvalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                print(error.localizedDescription)
                switch error {
                case is URLError:
                    return .RequestFailed(error)
                case is DecodingError:
                    return .DecodingFailed(error)
                default:
                    return .InvalidURL
                }
            }
            .eraseToAnyPublisher()
    }
}
