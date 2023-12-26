//
//  NetworkError.swift
//  GiphyApp
//
//  Created by Denis Chernovs on 23/12/2023.
//

import Foundation

enum NetworkError: Error {
    case InvalidURL
    case RequestFailed(Error)
    case DecodingFailed(Error)
    case success
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case uriTooLong
    case tooManyRequests
    case internalServerError
    case unknownError           
    
    var errorMessage: String {
        switch self {
        case .success:
            return "Your request was successful!"
        case .badRequest:
            return "Bad Request: Your request was formatted incorrectly or missing a required parameter(s)."
        case .unauthorized:
            return "Unauthorized: Your request lacks valid authentication credentials for the target resource."
        case .forbidden:
            return "Forbidden: You weren't authorized to make your request; most likely an issue with your API Key."
        case .notFound:
            return "Not Found: The particular GIF or Sticker you are requesting was not found."
        case .uriTooLong:
            return "URI Too Long: The length of the search query exceeds 50 characters."
        case .tooManyRequests:
            return "Too Many Requests: Your API Key is making too many requests."
        case .internalServerError:
            return "Internal Server Error: An unexpected condition was encountered on the server."
        case .InvalidURL:
            return "Invalid URL: The URL provided was not valid."
        case .RequestFailed:
            return "Request Failed: The server failed to fulfill an apparently valid request."
        case .DecodingFailed:
            return "Decoding Error: There was a problem processing the data received from the server."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

