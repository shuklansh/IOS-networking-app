//
//  Constants.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 13/04/24.
//

import Foundation

extension String {
    var replaceSpaceWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
    var replaceSpaceWithNothing: String {
        self.replacingOccurrences(of: " ", with: "")
    }
    var lowerNoSpaces: String  {
        self.replaceSpaceWithNothing.lowercased()
    }
}

enum Constants {
    static let bcsName = "Better Call Saul"
    static let bbName = "Breaking Bad"
}
