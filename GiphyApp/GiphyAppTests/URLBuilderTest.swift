//
//  URLBuilderTest.swift
//  GiphyAppTests
//
//  Created by Denis Chernovs on 26/12/2023.
//

import XCTest
@testable import GiphyApp

final class URLBuilderTest: XCTestCase {
    let scheme = Configuration.scheme
    let host = Configuration.host
    let apiKey = Configuration.apiKey
    
    func testURLBuildingWithValidInputs() {
        let path = Configuration.trendingPath
        
        let expectingURL = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=FEsB0f2ujVSZQb25GrQwFpu8wyasiBHp&limit=10&rating=g&bundle=messaging_non_clips&offset=0")
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: Configuration.apiKey),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "rating", value: "g"),
            URLQueryItem(name: "bundle", value: "messaging_non_clips"),
            URLQueryItem(name: "offset", value: "0")
        ]
        
        let url = URLBuilder.buildURL(scheme: scheme, host: host, path: path, urlQuery: queryItems)
        
        XCTAssertNotNil(url, "URL should not be nil")
        XCTAssertEqual(url, expectingURL!)
    }
    
    func testURLBuildingWithEmptyQuery() {
        let path = Configuration.searchPath
        
        let expectingURL = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=FEsB0f2ujVSZQb25GrQwFpu8wyasiBHp&limit=10&rating=g&bundle=messaging_non_clips&offset=0&q=test")
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: Configuration.apiKey),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "rating", value: "g"),
            URLQueryItem(name: "bundle", value: "messaging_non_clips"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "q", value: "test")
        ]
        
        let url = URLBuilder.buildURL(scheme: scheme, host: host, path: path, urlQuery: queryItems)
        
        XCTAssertNotNil(url, "URL should not be nil")
        XCTAssertEqual(url, expectingURL!)
    }
    
}
