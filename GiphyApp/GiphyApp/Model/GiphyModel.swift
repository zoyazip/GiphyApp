//
//  GiphyModel.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import Foundation

struct GiphyModel: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: String
    let username: String
    let title: String
    let images: Images
    let import_datetime: String
    let url: String
}

// MARK: - Images
struct Images: Codable {
    let original: FixedHeight
}

// MARK: - FixedHeight
struct FixedHeight: Codable {
    let height, width: String
    let url: String
    
}

