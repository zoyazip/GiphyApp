//
//  GifDetailView.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import SwiftUI

struct GifDetailView: View {
    var title: String = "Gif title"
    var author: String = "Gif author"
    var dimensions: String = "300x300"
    var date: String = "25.03.2024"
    var url: String = "Https://www.google.com/"
    
    private let width = UIScreen.main.bounds.width
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: width, height: 400)
                .foregroundColor(.green)
                .scaledToFill()
            VStack {
                HStack {
                    Text("Title:")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                    Text(title)
                        .font(.system(size: 20))
                }.padding(.bottom)
                HStack {
                    Text("Author:")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                    Text(author)
                        .font(.system(size: 20))
                }.padding(.bottom)
                HStack {
                    Text("Dimensions:")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                    Text(dimensions)
                        .font(.system(size: 20))
                }.padding(.bottom)
                HStack {
                    Text("Date:")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                    Text(date)
                        .font(.system(size: 20))
                }.padding(.bottom)
            }.padding()
            
            Spacer()
            
        }.navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Navigation Bar Button Tapped")
                    }) {
                        Image(systemName: "doc.on.doc")
                    }
                }
            }
    }
}

#Preview {
    GifDetailView()
}
