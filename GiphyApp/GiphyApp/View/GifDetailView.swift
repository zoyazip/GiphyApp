//
//  GifDetailView.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI


struct GifDetailView: View {
    var giphy: Datum?
    
    private let deviceWidth = UIScreen.main.bounds.width
    private let pastboard = UIPasteboard.general
    
    @State private var showCopiedPopup = false
    
    var body: some View {
        ScrollView {
            VStack {
                gifImageView
                detailsView
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        pastboard.string = giphy?.images.original.url
                        showCopiedPopup = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showCopiedPopup = false
                        }
                    }) {
                        Image(systemName: "doc.on.doc")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .buttonStyle(PlainButtonStyle())
        seeOriginalButton
            .overlay(copiedPopup, alignment: .center)
    }
    
    private var gifImageView: some View {
        AnimatedImage(url: URL(string: giphy?.images.original.url ?? ""))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: deviceWidth, height: 400)
            .clipped()
    }
    
    private var detailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            detailRow(title: "Id:", value: giphy?.id ?? "Unknown ID")
            detailRow(title: "Title:", value: giphy?.title ?? "Unknown Title")
            detailRow(title: "Author:", value: giphy?.username ?? "Unknown Author")
            detailRow(title: "Dimensions:", value: "\(giphy?.images.original.width ?? "Unknown") x \(giphy?.images.original.height ?? "Unknown")")
            detailRow(title: "Date:", value: giphy?.import_datetime ?? "Unknown Date")
        }
        .padding()
    }
    
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text(value)
                .font(.system(size: 20))
                .multilineTextAlignment(.trailing)
        }
    }
    
    private var seeOriginalButton: some View {
        Button("See Original") {
            if let urlString = giphy?.url, let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    private var copiedPopup: some View {
        Text("Copied to clipboard")
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(8)
            .background(Color.black.opacity(0.75))
            .cornerRadius(10)
            .opacity(showCopiedPopup ? 1 : 0)
            .animation(.easeInOut, value: showCopiedPopup)
            .frame(maxWidth: 200)
    }
}

// Preview
struct GifDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GifDetailView()
    }
}
