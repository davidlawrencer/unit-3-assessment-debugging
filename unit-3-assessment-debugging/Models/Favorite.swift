//
//  Favorite.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    let elementName: String
    let favoriteBy: String
    let elementSymbol: String
    
    static func decodeFavoritesFromJSON(from jsonData: Data) throws -> [Favorite] {
        let response = try JSONDecoder().decode([Favorite].self, from: jsonData)
        return response
    }
    
    enum CodingKeys: String, CodingKey {
        case elementName, favoriteBy, elementSymbol
    }

}
