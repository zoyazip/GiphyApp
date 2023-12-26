//
//  GiphyViewModel.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//


import Foundation
import Combine

protocol GiphyViewModelType {
    func fetchDataByPrompt(search: String, isLoadMore: Bool)
    func fetchDataByTrending(isLoadMore: Bool)
    var giphyData: [Datum] { get set }
    var networkError: NetworkError? { get set }
}

public class GiphyViewModel: ObservableObject {
    
    @Published var networkError: NetworkError?
    @Published var giphyData: [Datum] = []
    @Published var trendingSearch: [String] = []
    
    private let configuration: Configuration = Configuration()
    
    var cancellables = Set<AnyCancellable>()
    
    private var offset = 0
    private var currentSearch: String?
    private let searchSubject = PassthroughSubject<String, Never>()
    
    init() {
        searchSubject
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] search in
                self?.fetchDataByPrompt(search: search)
            }
            .store(in: &cancellables)
    }
    
    func fetchDataByPrompt(search: String, isLoadMore: Bool = false) {
        
        if (!isLoadMore) {
            cleanGiphy()
            currentSearch = search
            offset = 0
        }
        
        var formattedSearch = search
        
        formattedSearch = search.replacingOccurrences(of: " ", with: "+")
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: Configuration.apiKey),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "rating", value: "g"),
            URLQueryItem(name: "bundle", value: "messaging_non_clips"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "q", value: "\(formattedSearch)")
        ]
        
        if let url = URLBuilder
            .buildURL(
                scheme: Configuration.scheme,
                host: Configuration.host,
                path: Configuration.searchPath,
                urlQuery: queryItems) {
            
            fetchData(url: url)
        }
        offset += 11
    }
    
    func fetchDataByTrending(isLoadMore: Bool = false) {
        if (!isLoadMore) {
            cleanGiphy()
            currentSearch = nil
            offset = 0
        }
        
        let queryItems = [
            URLQueryItem(name: "api_key", value: Configuration.apiKey),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "rating", value: "g"),
            URLQueryItem(name: "bundle", value: "messaging_non_clips"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        if let url = URLBuilder
            .buildURL(scheme: Configuration.scheme,
                      host: Configuration.host,
                      path: Configuration.trendingPath,
                      urlQuery: queryItems) {
            
            fetchData(url: url)
        }
        offset += 11
    }
    
    private func fetchData(url: URL) {
        NetworkManager.fetchData(using: url)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    if let networkError = error as? NetworkError {
                        self?.networkError = networkError
                        print(networkError.errorMessage)
                    }
                case .finished:
                    print("Fetch operation completed successfully.")
                }
            }, receiveValue: { [weak self] (fetchedData: GiphyModel) in
                self?.giphyData.append(contentsOf: fetchedData.data)
            })
            .store(in: &cancellables)
    }
    
    func fetchTrendingSearch() {
        let queryItems = [
            URLQueryItem(name: "api_key", value: Configuration.apiKey),
        ]
        
        if let url = URLBuilder
            .buildURL(scheme: Configuration.scheme,
                      host: Configuration.host,
                      path: Configuration.trendingSearch,
                      urlQuery: queryItems) {
            
            NetworkManager.fetchData(using: url)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        if let networkError = error as? NetworkError {
                            self?.networkError = networkError
                            print(networkError.errorMessage)
                        }
                    case .finished:
                        print("Fetch operation completed successfully.")
                    }
                }, receiveValue: { [weak self] (fetchedData: SearchTrending) in
                    self?.trendingSearch.append(contentsOf: fetchedData.data)
                })
                .store(in: &cancellables)
        }
        
    }
    
    public func cleanGiphy() -> Int {
        giphyData.removeAll()
        return giphyData.count
    }
    
    func loadMoreContent() {
        if let search = currentSearch {
            fetchDataByPrompt(search: search, isLoadMore: true)
        } else {
            fetchDataByTrending(isLoadMore: true)
        }
    }
    
    func updateSearchText(_ newText: String) {
        searchSubject.send(newText)
    }
    
}
