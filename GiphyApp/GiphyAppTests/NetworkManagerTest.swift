//
//  NetworkManagerTest.swift
//  GiphyAppTests
//
//  Created by Denis Chernovs on 26/12/2023.
//

import XCTest
import Combine
@testable import GiphyApp

final class NetworkManagerTest: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    
    let goodURL = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=FEsB0f2ujVSZQb25GrQwFpu8wyasiBHp&limit=26&offset=0&rating=g&bundle=messaging_non_clips")
    let badApi = URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=FEsB0f2ujVSZQb25GrQwFpu8wyasiBHp1&limit=26&offset=0&rating=g&bundle=messaging_non_clips")
    let outOfLimitQuery = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=FEsB0f2ujVSZQb25GrQwFpu8wyasiBHp&q=hghghghghghghghghghghghghghghghghghghghghghghghghgh&limit=26&offset=0&rating=g&lang=en&bundle=messaging_non_clips")
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func successFetch() {
        NetworkManager.fetchData(using: goodURL)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Request failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { (response: GiphyModel) in
                
                XCTAssertNotNil(response, "Response should not be nil")
            })
            .store(in: &cancellables)
        
    }
    
    func testBadApi() {
        let expectation = XCTestExpectation(description: "Handle unauthorized error due to bad API key")
        
        NetworkManager.fetchData(using: badApi)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case .unauthorized = error {
                        XCTAssertEqual(error.errorMessage, "Unauthorized: Your request lacks valid authentication credentials for the target resource.", "Error message for unauthorized does not match expected text.")
                        break
                    } else {
                        XCTFail("Expected unauthorized error, received \(error)")
                    }
                case .finished:
                    XCTFail("Request should not finish successfully with a bad API key")
                }
                expectation.fulfill()
            }, receiveValue: { (response: GiphyModel) in
                XCTFail("No response should be received for an unauthorized error")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testOutOfLimitQuery() {
        let expectation = XCTestExpectation(description: "Handle URI too long error")
        
        NetworkManager.fetchData(using: outOfLimitQuery)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case .uriTooLong = error {
                        // Check if the error message is as expected
                        XCTAssertEqual(error.errorMessage, "URI Too Long: The length of the search query exceeds 50 characters.", "Error message for uriTooLong does not match expected text.")
                        break
                    } else {
                        XCTFail("Expected uriTooLong error, received \(error)")
                    }
                case .finished:
                    XCTFail("Request should not finish successfully for a URI too long error")
                }
                expectation.fulfill()
            }, receiveValue: { (response: GiphyModel) in
                XCTFail("No response should be received for a URI too long error")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}

