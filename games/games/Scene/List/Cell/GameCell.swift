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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView?.image = nil
    }
    
    var item:  GamePresentation! {
        didSet {
            nameLabel.text = item.name
            genreLabel.text = item.genres.joined(separator: ", ")
        }
    }
    
    func setImage(_ image: UIImage) {
        gameImageView.image = image
    }
}
