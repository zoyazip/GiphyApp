//
//  NetworkError.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import Foundation

enum NetworkError: Error {
    case InvalidURL
    case RequestFailed(Error)
    case DecodingFailed(Error)
}
