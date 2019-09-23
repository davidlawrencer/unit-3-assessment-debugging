//
//  ViewController.swift
//  unit-3-assessment-debugging
//
//  Created by David Rifkin on 9/22/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {

    // MARK: - Storyboard Outlets

    @IBOutlet weak var elementsTableView: UITableView!
    
    // MARK: - Properties

    var elements = [Element]() {
        didSet {
            elementsTableView.reloadData()
        }
    }
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = elementsTableView.indexPathForSelectedRow else {
            showCouldntSegueAlert(element: nil)
            return
        }
        
        let element = elements[selectedIndex.row]
        
        guard segue.identifier == "elementListToDetailSegue" else {
            showCouldntSegueAlert(element: element.name)
            return
        }

        guard let elementDetailsVC = segue.destination as? ElementDetailViewController else {
            showCouldntSegueAlert(element: element.name)
            return
        }
        
        elementDetailsVC.element = element
    }
    
    // MARK: - Private Methods

    private func configureTableView() {
        elementsTableView.delegate = self
        elementsTableView.dataSource = self
    }
    
    private func loadData() {
        ElementAPIClient.manager.getElements { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let ElementsFromOnline):
                    self.elements = ElementsFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func showCouldntSegueAlert(element: String?) {
        let element = element ?? "that element"
        let alertController = UIAlertController(title: "Sorry", message: "Something went wrong. Can't show details for \(element)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - TableView Data Source

extension ElementsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as! ElementTableViewCell
        let element = elements[indexPath.row]
        
        cell.nameLabel.text = element.name
        cell.weightLabel.text = element.symbolAndMass
        
        let imageURLString = ElementAPIClient.getElementThumbImageURLString(from: element.number)
        
        ImageHelper.shared.getImage(urlStr: imageURLString) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    cell.thumbnailImage.image = image
                    
                case .failure(let error):
                    print(imageURLString)
                    print(error)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Check out these elements!!!!!"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - TableView Delegate

extension ElementsViewController: UITableViewDelegate {}
