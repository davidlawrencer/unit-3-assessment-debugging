//
//  FavoritesTableViewController.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    private var favorites = [Favorite]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - TableView data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorites"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite = favorites[indexPath.row]

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

        cell.textLabel?.text = "\(favorite.elementName)(\(favorite.elementSymbol)) "
        cell.detailTextLabel?.text = favorite.favoritedBy
        
        return cell
    }
    
    private func loadData() {
        FavoritesAPIClient.manager.getFavorites { (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .failure(let error):
                    print("nope \(error)")
                case .success(let favoritesFromOnline):
                    self?.favorites = favoritesFromOnline
                }
            }
        }
    }
    

}
