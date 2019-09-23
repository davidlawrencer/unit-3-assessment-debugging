//
//  FavoriteAPIClient.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct FavoritesAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = FavoritesAPIClient()
    
    // MARK: - Instance Methods

    // MARK: - Private Properties and Initializers

    private var favoriteURL: URL {
        guard let url = URL(string: "http5d83bc5ebaffda001476aa88.mockapi.io/api/v1/favorites") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
