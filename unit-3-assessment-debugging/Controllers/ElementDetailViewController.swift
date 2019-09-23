//
//  ViewController.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//


import UIKit

class ElementDetailViewController: UIViewController {

    // MARK: - Storyboard Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var discoveredByLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var element: Element!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupElementDetails()
        navigationItem.title = element.name
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let favorite = Favorite(elementName: element.name, favoritedBy: "David", elementSymbol: element.symbol)
        
        FavoritesAPIClient.manager.postElement(element: favorite) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.showFavoriteAlert()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: - Private Methods

    private func setupElementDetails() {
        nameLabel.text = element.name
        symbolLabel.text = element.symbol
        numberLabel.text = element.number.description
        weightLabel.text = element.atomicMass.description
        meltingPointLabel.text = element.meltingPoint?.description
        boilingPointLabel.text = element.boilingPoint?.description
        discoveredByLabel.text = element.discoveredBy
        
        let imageURLString = ElementAPIClient.getElementLargeImageURLString(from: element.name)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        ImageHelper.shared.getImage(urlStr: imageURLString) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    self.elementImage.image = UIImage(named: "noImage")
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    
                case .success(let imageFromOnline):
                    self.elementImage.image = imageFromOnline
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func showFavoriteAlert() {
        let alertController = UIAlertController(title: "Success", message: "Favorited \(element.name)!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
