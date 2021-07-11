//
//  GamePresentation.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import UIKit

struct GamePresentation {
    let id: Int
    let name:  String
    let genre: String
    let imageLink: String
    
    init(model: ListItemResponse) {
        self.id = model.id
        self.name = model.name
        self.genre = "gelcek"
        self.imageLink = model.imageURL
    }
}
