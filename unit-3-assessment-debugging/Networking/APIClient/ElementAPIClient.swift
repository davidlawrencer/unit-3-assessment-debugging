//
//  ElementAPIClient.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct ElementAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = ElementAPIClient()
    
    // MARK: - Instance Methods
    
    static func getElementThumbImageURLString(from number: Int) -> String {
        return "https://theodoregray.com/periodictable/Tiles/\(number.getStringForThumbnailImage())/s7.JPG"
    }
    
    static func getElementLargeImageURLString(from name: String) -> String {
        return "http://images-of-elements.com/\(name.lowercased()).jpg"
    }
    
    func getElements(completionHandler: @escaping (Result<[Element], AppError>) -> ())  {
        NetworkHelper.manager.performDataTask(withUrl: elementURL, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let elementInfo = try Element.decodeElementsFromData(from: data)
                    completionHandler(.success(elementInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }

    
    // MARK: - Private Properties and Initializers

    private var elementURL: URL {
        guard let url = URL(string: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
        
    private init() {}
}
