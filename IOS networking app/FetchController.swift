//
//  FetchController.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 11/04/24.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case urlError, responseError
    }
    
    private let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // building url starts
        let quoteUrl = baseUrl.appending(path: "quotes/random")
        var quoteComponents = URLComponents(
            url: quoteUrl,
            resolvingAgainstBaseURL: true
        )
        // query items (?production=Breaking+Bad)
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replacingOccurrences(of: " ", with: "+"))
        quoteComponents?.queryItems = [quoteQueryItem]
        // fetchUrl is final url
        guard let fetchUrl = quoteComponents?.url else {
            throw NetworkError.urlError
        }
        // api call starts
        let (data,response) = try await URLSession.shared.data(from: fetchUrl)
        
        // check if api call success else throw error
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.responseError
        }
        // decode data into data model and return
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        return quote
    }
}
