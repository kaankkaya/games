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
    let imageLink: String
    let genres: [String]
    
    init(model: ListDTO) {
        self.id = model.id
        self.name = model.name
        self.imageLink = model.imageURL
        self.genres = model.genres.map { $0.name }
    }
}
