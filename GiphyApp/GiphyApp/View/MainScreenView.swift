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
    @State private var showAlert = false
    @State private var errorMessage: String?
    
    private let gridItemLayout = [GridItem(.adaptive(minimum: 150))]
    private let gridSpacing: CGFloat = 16
    private let horizontalScrollSpacing: CGFloat = 10
    private let buttonPadding: CGFloat = 10
    private let cornerRadius: CGFloat = 16
    private let gifItemHeight: CGFloat = 200
    private let gifItemBackgroundColor = Color(hex: "#E3E8E6")
    
    var body: some View {
        NavigationView {
            ScrollView {
                trendingSearchView
                if (giphyViewModel.giphyData.isEmpty && !searchText.isEmpty) {
                    Spacer()
                    Text("No Results")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    gifGridView
                }
            }
            .padding(.horizontal, 10)
            .navigationTitle("Gifs")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Gif")
            .onSubmit(of: .search) {
                giphyViewModel.fetchDataByPrompt(search: searchText, isLoadMore: false)
            }
            .onAppear {
                giphyViewModel.fetchDataByTrending(isLoadMore: false)
                giphyViewModel.fetchTrendingSearch()
            }
            .onChange(of: searchText) { newValue in
                newValue.isEmpty ? giphyViewModel.fetchDataByTrending(isLoadMore: false) : giphyViewModel.updateSearchText(newValue)
            }
            .onReceive(giphyViewModel.$networkError) { error in
                if let error = error {
                    errorMessage = error.errorMessage
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage ?? "An error occurred"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // Displaying trending requests as a LazyHGrid
    private var trendingSearchView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: horizontalScrollSpacing) {
                ForEach(giphyViewModel.trendingSearch, id: \.self) { item in
                    Button(action: {
                        searchText = item
                    }, label: {
                        Text(item)
                            .padding(.vertical, buttonPadding)
                            .padding(.horizontal, buttonPadding * 2)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    })
                }
            }
            .padding(.vertical, buttonPadding)
        }
    }
    
    // Displaying Fetched gifs
    private var gifGridView: some View {
        LazyVGrid(columns: gridItemLayout, spacing: gridSpacing) {
            ForEach(giphyViewModel.giphyData, id: \.id) { item in
                NavigationLink(destination: GifDetailView(giphy: item)) {
                    gifItemView(for: item)
                }
            }
        }
    }
    
    // Representation of Grid Gif item
    private func gifItemView(for item: Datum) -> some View {
        ZStack {
            ProgressView()
            AnimatedImage(url: URL(string: item.images.original.url))
        }
        .frame(width: gridItemWidth, height: gifItemHeight, alignment: .center)
        .background(gifItemBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .aspectRatio(contentMode: .fill)
        .onAppear {
            if item.id == giphyViewModel.giphyData.last?.id {
                giphyViewModel.loadMoreContent()
            }
        }
    }
    // Getting dynamicaly grid item width
    private var gridItemWidth: CGFloat {
        (UIScreen.main.bounds.width / 2) - (gridSpacing * 2)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
