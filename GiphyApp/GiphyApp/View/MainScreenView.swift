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
                        NavigationLink(destination: GifDetailView(
                            title: item.title, author: item.username,
                            width: item.images.original.width,
                            height: item.images.original.height,
                            date: item.import_datetime,
                            url: item.images.original.url,
                            originalUrl: item.url)) {
                            ZStack {
                                ProgressView()
                                AnimatedImage(url: URL(string: item.images.original.url))
                            }.frame(width: width, height: 200, alignment: .center)
                                .background(Color(hex: "#E3E8E6"))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Gifs")
        }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Gif")
            .onSubmit(of: .search) {
                print(searchText)
            }
            .onAppear {
                giphyViewModel.fetchData()
            }
            .onChange(of: searchText) { newValue in
                
            }
        
    }
}


#Preview {
    ContentView()
}
