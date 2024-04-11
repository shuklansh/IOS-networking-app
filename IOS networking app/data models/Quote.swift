//
//  Quote.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 11/04/24.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    let production: String
}
