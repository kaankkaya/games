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
    private var visitedIds: [Int] = []
    
    var vm: ListVM! {
        didSet {
            vm.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Games"
        
        // Search Bar
        searchController.obscuresBackgroundDuringPresentation = false
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
        
        
        cell.listItem = models[indexPath.row]
        
        if visitedIds.contains(cell.listItem.id) {
            cell.backgroundColor = .lightGray
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! GameCell
        // Imge request
        if let item = cell.listItem {
            vm.requestImage(for: item.id, link: item.imageLink)
        }
        // Pagination
        if (indexPath.row + 1) % GameService.Constants.count == 0,
           tableView.numberOfRows(inSection: 0) == indexPath.row + 1  {
            vm.load(page: ((indexPath.row + 1) / GameService.Constants.count) + 1)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GameCell else {
            print("ListVC: Could not find cell for detail!")
            
            return
        }
        visitedIds.append(cell.listItem.id)
        cell.backgroundColor = .lightGray
        let vc = DetailBuilder.makeWith(cell.listItem.id, title: cell.listItem.name)
        show(vc, sender: nil)
    }
}
// MARK: - View Model
extension ListVC: ListVMDelegate {
    func handle(image: UIImage, for id: Int) {
        DispatchQueue.main.async { [weak self] in
            let cell = self?.tableView.visibleCells.first(where: { ($0 as! GameCell).listItem.id == id }) as? GameCell
            cell?.setImage(image)
        }
    }
    
    func handle(models: [GamePresentation], page: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if page != 1 {
                self.models.append(contentsOf: models)
                let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                let indices = (numberOfRows..<numberOfRows + models.count).map {
                    IndexPath(row: $0, section: 0)
                }
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indices, with: .fade)
                self.tableView.endUpdates()
            } else {
                self.models = models
                self.tableView.reloadData()
            }
        }
    }
}
// MARK: - Search Bar Delegate
extension ListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.query = searchText.isEmpty ? nil : searchText
    }
}

