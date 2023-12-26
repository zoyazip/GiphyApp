//
//  ContentView.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject private var giphyViewModel = GiphyViewModel()
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    private let width = (UIScreen.main.bounds.width/2) - 32
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum:150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                    ForEach(giphyViewModel.giphyData, id: \.id) { item in
                        NavigationLink(destination: GifDetailView(giphy: item)) {
                            ZStack {
                                ProgressView()
                                AnimatedImage(url: URL(string: item.images.original.url))
                            }
                            .frame(width: width, height: 200, alignment: .center)
                            .background(Color(hex: "#E3E8E6"))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .aspectRatio(contentMode: .fill)
                            .onAppear {
                                if item.id == giphyViewModel.giphyData.last?.id {
                                    giphyViewModel.loadMoreContent()
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Gifs")
        }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Gif")
                .onSubmit(of: .search) {
                    giphyViewModel.fetchDataByPrompt(search: searchText, isLoadMore: false)
                }
                .onAppear {
                    giphyViewModel.fetchDataByTrending(isLoadMore: false)
                }
                .onChange(of: searchText) { newValue in
                    giphyViewModel.updateSearchText(newValue)
                }
    }
}


#Preview {
    ContentView()
}
