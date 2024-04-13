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
}
