//
//  NetworkManager.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import Foundation
import Combine


protocol NetworkManagerType {
    static func fetchData<T: Codable>(using apiUrl: URL?) -> AnyPublisher<T, NetworkError>
}

class NetworkManager: NetworkManagerType {
    
    //        static func fetchData<T: Codable>(using apiUrl: URL?) -> AnyPublisher<T, NetworkError> {
    //
    //            guard let url = apiUrl else {
    //                return Fail(error: NetworkError.InvalidURL).eraseToAnyPublisher()
    //            }
    //
    //            return URLSession.shared
    //                .dataTaskPublisher(for: url)
    //                .receive(on: DispatchQueue.main)
    //                .map(\.data)
    //                .decode(type: T.self, decoder: JSONDecoder())
    //                .mapError { error in
    //                    switch error {
    //                    case is URLError:
    //                        return .RequestFailed(error)
    //                    case is DecodingError:
    //                        return .DecodingFailed(error)
    //                    default:
    //                        return .InvalidURL
    //                    }
    //                }
    //                .eraseToAnyPublisher()
    //        }
    static func fetchData<T: Codable>(using apiUrl: URL?) -> AnyPublisher<T, NetworkError> {
        guard let url = apiUrl else {
            return Fail(error: NetworkError.InvalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError.unknownError
                }
                
                switch httpResponse.statusCode {
                case 200:
                    return output.data
                case 400:
                    throw NetworkError.badRequest
                case 401:
                    throw NetworkError.unauthorized
                case 403:
                    throw NetworkError.forbidden
                case 404:
                    throw NetworkError.notFound
                case 414:
                    throw NetworkError.uriTooLong
                case 429:
                    throw NetworkError.tooManyRequests
                default:
                    throw NetworkError.unknownError
                }
            }
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else if let urlError = error as? URLError {
                    return .RequestFailed(urlError)
                } else if let decodingError = error as? DecodingError {
                    return .DecodingFailed(decodingError)
                } else {
                    return .unknownError
                }
            }
            .eraseToAnyPublisher()
    }
    
}
