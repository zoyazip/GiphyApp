//
//  URLBuilder.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import Foundation

class URLBuilder {
    static func buildURL(scheme: String, host: String, path: String, urlQuery: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = urlQuery.isEmpty ? nil : urlQuery
        
        return components.url
    }
}
