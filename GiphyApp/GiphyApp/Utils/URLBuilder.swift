//
//  URLBuilder.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import Foundation

class URLBuilder {
    private var components: URLComponents
    
    init?(baseUrl: String) {
        guard let components = URLComponents(string: baseUrl) else { return nil };
        self.components = components
    }
    
    func set(path: String) -> URLBuilder {
        components.path = path
        return self
    }
    
    func addQueryItem(name: String, value: String?) -> URLBuilder {
        var queryItems = components.queryItems ?? []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        components.queryItems = queryItems
        
        return self
    }
    
    func build() -> URL? {
        return components.url
    }
}
