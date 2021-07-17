//
//  RequestDTO.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import Foundation

struct ListResponse: Decodable {
    let results: [ListItemResponse]
}

struct ListItemResponse: Decodable {
    let id: Int
    let name: String
    let imageURL: String
//    let genres: [ListItemGenreResponse]
    
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             imageURL = "background_image"
//             genres
    }
}

struct ListItemGenreResponse: Decodable {
    let id: Int
    let name: String
    let imageLink: String
    
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             imageLink = "image_background"
    }
}
// Favorite Model
struct FavoriteDTO: Decodable, Encodable {
    let id: Int
    let name: String
    let genres: String
    let imageData: Data
    
    init(gameDTO: GameDTO, imageData: Data) {
        self.id = gameDTO.id
        self.name = gameDTO.name
        self.genres = gameDTO.genres.map { $0.name }.joined(separator: ", ")
        self.imageData = imageData
    }
}

// Detail Model
struct GameDTO: Decodable {
    let id: Int
    let name: String
    let imageLink: String
    let additionalImageLink: String
    let genres: [ListItemGenreResponse]
    let description: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             imageLink = "background_image",
             additionalImageLink = "background_image_additional",
             genres,
             description,
             website
    }
}
