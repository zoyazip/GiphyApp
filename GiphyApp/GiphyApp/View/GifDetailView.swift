//
//  GifDetailView.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import UIKit

struct GifDetailView: View {
    
    var giphy: Datum?
    
    private let deviceWidth = UIScreen.main.bounds.width
    var body: some View {
        ScrollView {
            VStack {
                AnimatedImage(url: URL(string: (giphy?.images.original.url)!))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: deviceWidth, height: 400, alignment: .center)
                    .clipped()
                
                VStack {
                    HStack(alignment: .top) {
                        Text("Id:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(giphy?.id ?? "Unknown Date")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                    HStack(alignment: .top) {
                        Text("Title:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(giphy?.title ?? "Unknown Title")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                    HStack(alignment: .top) {
                        Text("Author:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(giphy?.username ?? "Unknown Author")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                    HStack(alignment: .top) {
                        Text("Dimensions:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text("\(giphy?.images.original.width ?? "Unknown")x\(giphy?.images.original.height ?? "Unknown")")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                    HStack(alignment: .top) {
                        Text("Date:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(giphy?.import_datetime ?? "Unknown Date")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                }.padding()
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Navigation Bar Button Tapped")
                    }) {
                        Image(systemName: "doc.on.doc")
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        }
        Button("See Original") {
            print("Clicked See orginal Button")
            if let urlString = giphy?.url, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
}

#Preview {
    GifDetailView()
}
