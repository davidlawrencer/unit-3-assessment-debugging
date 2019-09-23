//
//  Element.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let symbol: String
    let number: Int
    let atomicMass: Double
    let meltingPoint: Double?
    let boilingPoint: Double?
    let discoveredBy: String?
    
    var symbolAndMass: String {
        return "\(symbol)(\(number))  \(atomicMass)"
    }
    
    enum CodingKeys: String, CodingKey {
        case atomicMass = "atomicmass"
        case meltingPoint = "melt"
        case boilingPoint = "boil"
        case discoveredBy = "discoveredby"
        case name,symbol,number
    }
    
    static func decodeElementsFromData(from jsonData: Data) throws -> [Element] {
        let response = try JSONDecoder().decode(Element.self, from: jsonData)
        return response
    }

}
