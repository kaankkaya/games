//
//  ListVC.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

final class ListVC: UITableViewController {
    var vm: ListVM! {
        didSet {
            vm.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Games"
    }
}

extension ListVC: ListVMDelegate {
    
}
