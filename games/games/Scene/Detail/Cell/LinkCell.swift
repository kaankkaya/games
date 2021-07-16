//
//  LinkCell.swift
//  games
//
//  Created by Kaan Kaya on 17.07.2021.
//

import UIKit

final class LinkCell: UITableViewCell {
    @IBOutlet private weak var button: UIButton!
    
    static let index: Int = 2
    
    var url: URL!
    
    @IBAction private func linkTapped() {
        guard UIApplication.shared.canOpenURL(url) else {
            print("Coul not open the game website!")
            
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
