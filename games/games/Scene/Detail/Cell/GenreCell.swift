//
//  GenreCell.swift
//  games
//
//  Created by Kaan Kaya on 16.07.2021.
//

import UIKit

final class GenreCell: UITableViewCell {
    @IBOutlet private weak var label: UILabel!
    
    static let index: Int = 0
    
    func setText(_ text: String) {
        label.text = text
    }
}
