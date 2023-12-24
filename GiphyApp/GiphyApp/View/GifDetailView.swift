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
    var title: String?
    var author: String?
    var width: String?
    var height: String?
    
    var date: String?
    var url: String?
    
    var originalUrl: String?
    
    private let deviceWidth = UIScreen.main.bounds.width
    var body: some View {
        ScrollView {
            VStack {
                AnimatedImage(url: URL(string: url ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: deviceWidth, height: 400, alignment: .center)
                    .clipped()
                
                VStack {
                    HStack(alignment: .top) {
                        Text("Title:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(title ?? "Unknown Title")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                    HStack(alignment: .top) {
                        Text("Author:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(author ?? "Unknown Author")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                    HStack(alignment: .top) {
                        Text("Dimensions:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(width ?? "Unknown Dimensions")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                    }.padding(.bottom)
                    HStack(alignment: .top) {
                        Text("Date:")
                            .bold()
                            .font(.system(size: 20))
                        Spacer()
                        Text(date ?? "Unknown Date")
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
            if let url = URL(string: originalUrl!) {
                UIApplication.shared.open(url)
            }
        }
    }
    
}

#Preview {
    GifDetailView()
}
