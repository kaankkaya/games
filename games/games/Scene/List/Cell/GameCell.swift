//
//  GameCell.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import UIKit

final class GameCell: UITableViewCell {
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel:UILabel!
    
    var item:  GamePresentation! {
        didSet {
            nameLabel.text = item.name
            genreLabel.text = item.genre
        }
    }
    
    func setImage(_ image: UIImage) {
        gameImageView.image = image
    }
}
