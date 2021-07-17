//
//  FavoriteVC.swift
//  games
//
//  Created by Kaan Kaya on 17.07.2021.
//

import UIKit

final class FavoriteVC: UITableViewController {
    var vm: FavoriteVM!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.load()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameCell
        let item = vm.favorites[indexPath.row]
        cell.favoriteItem = item
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard (editingStyle == .delete) else { return }
        
        let id = (tableView.cellForRow(at: indexPath) as! GameCell).favoriteItem.id
        
        let alertController = UIAlertController(title: "Remove from favorirtes?",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            self?.vm.remove(id: id)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        [removeAction, cancelAction].forEach(alertController.addAction)
        
        present(alertController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = (tableView.cellForRow(at: indexPath) as! GameCell).favoriteItem else { return }
        
        let vc = DetailBuilder.makeWith(item.id, title: item.name)
        
        show(vc, sender: self)
    }
}
