//
//  ListVC.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

final class ListVC: UITableViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var models: [GamePresentation] = []
    
    var vm: ListVM! {
        didSet {
            vm.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Games"
        
        // Search Bar
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        vm.load()
    }
    
    // MARK: Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameCell else {
            fatalError("Table view could not deque the cell check the ID!")
        }
        
        cell.item = models[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! GameCell
        guard let item = cell.item else { return }
        vm.requestImage(for: item.id, link: item.imageLink)
    }
}
// MARK: - View Model
extension ListVC: ListVMDelegate {
    func handle(image: UIImage, for id: Int) {
        DispatchQueue.main.async { [weak self] in
            let cell = self?.tableView.visibleCells.first(where: { ($0 as! GameCell).item.id == id }) as? GameCell
            cell?.setImage(image)
        }
    }
    
    func handle(models: [GamePresentation], page: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.models = models
            self?.tableView.reloadData()
        }
    }
}
// MARK: - Search Bar Delegate
extension ListVC: UISearchBarDelegate {
    
}

