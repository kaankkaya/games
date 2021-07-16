//
//  DescriptionCell.swift
//  games
//
//  Created by Kaan Kaya on 17.07.2021.
//

import UIKit

final class DescriptionCell: UITableViewCell {
    @IBOutlet private weak var textView: UITextView!
    
    static let index: Int = 1
    
    func setText(_ text: String) {
        textView.text = text
    }
    
    func getDescriptionHeight() -> CGFloat {
        textView.sizeToFit()
        return textView.frame.height
    }
}
