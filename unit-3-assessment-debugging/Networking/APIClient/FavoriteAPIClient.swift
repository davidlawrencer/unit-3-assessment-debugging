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
    func postElement(element: Favorite, completionHandler: @escaping (Result< Data, AppError>) -> Void){
        guard let encodedFavorite = try? JSONEncoder().encode(element) else {
            completionHandler(.failure(.noDataReceived))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: favoriteURL, andHTTPBody: encodedFavorite, andMethod: .post){(result) in
            switch result {
            case .failure (let error):
                completionHandler(.failure(error))
            case .success(let data):
                completionHandler (.success(data))
            }
        }
    }
    
    
    func getFavorites(completionHandler: @escaping (Result<[Favorite],AppError>) -> () ) {
        
        NetworkHelper.manager.performDataTask(withUrl: favoriteURL, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let favoriteElements = try Favorite.decodeFavoritesFromJSON(from: data)
                    completionHandler(.success(favoriteElements))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
    
    // MARK: - Private Properties and Initializers

    private var favoriteURL: URL {
        guard let url = URL(string: "https://5d83bc5ebaffda001476aa88.mockapi.io/api/v1/favorites") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
