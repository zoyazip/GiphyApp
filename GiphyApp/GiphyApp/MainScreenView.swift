//
//  ContentView.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    
    private let width = (UIScreen.main.bounds.width/2) - 32
    private let data = Array(1...20)
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum:150))
    ]
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                    ForEach(data, id: \.self) { item in
                        NavigationLink(destination: GifDetailView()) {
                            Text(String(item))
                                .frame(width: width, height: 200, alignment: .center)
                                .background(Color(hex: "#E3E8E6"))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .font(.title)
                                .foregroundStyle(.black)
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
            .onChange(of: searchText) { newValue in
                
            }
            .accentColor(.white)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        print("info")
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                }
            }
    }
}


#Preview {
    ContentView()
}
