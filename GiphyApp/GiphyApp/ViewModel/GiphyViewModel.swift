//
//  GiphyViewModel.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//


import Foundation
import Combine

protocol GiphyViewModelProtocol {
    func fetchData()
    var giphyData: [Datum] { get set }
    var networkError: NetworkError? { get set }
}

class GiphyViewModel: ObservableObject, GiphyViewModelProtocol {
    
    @Published var networkError: NetworkError?
    @Published var giphyData: [Datum] = []
    
    private let configuration: Configuration = Configuration()
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        print("Fetch called")
        let baseURLString = "https://api.giphy.com/v1/gifs/trending?api_key=FEsB0f2ujVSZQb25GrQwFpu8wyasiBHp&limit=26&offset=0&rating=g&bundle=messaging_non_clips"
        
        NetworkManager.fetchData(using: baseURLString)
            
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.networkError = error
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (fetchedData: GiphyModel) in
                self?.giphyData.append(contentsOf: fetchedData.data)
                self?.giphyData.forEach({ data in
                    print(data.title)
                })
            })
            .store(in: &cancellables)
    }
}
