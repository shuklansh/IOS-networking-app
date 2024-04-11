//
//  Character.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 11/04/24.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupation: [String] // list of strings
    let image: [URL] // url are mostly strings so common form made by swift: URL
    let aliases: [String]
    let portayedBy: String
}
