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
    
    var listItem: GamePresentation! {
        didSet {
            nameLabel.text = listItem.name
            genreLabel.text = listItem.genres.joined(separator: ", ")
        }
    }
    
    var favoriteItem: FavoriteDTO! {
        didSet {
            nameLabel.text = favoriteItem.name
            genreLabel.text = favoriteItem.genres
            gameImageView.image = UIImage(data: favoriteItem.imageData)
        }
    }
    
    func setImage(_ image: UIImage) {
        gameImageView.image = image
    }
}
