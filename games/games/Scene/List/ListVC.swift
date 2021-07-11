//
//  ListVC.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

final class ListVC: UITableViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
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
    }
}
// MARK: - View Model
extension ListVC: ListVMDelegate {
    
}
// MARK: - Search Bar Delegate
extension ListVC: UISearchBarDelegate {
    
}

