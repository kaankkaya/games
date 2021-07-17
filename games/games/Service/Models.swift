//
//  Models.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import Foundation

struct ListResponse: Decodable {
    let results: [ListDTO]
}

// List Model
struct ListDTO: Decodable {
    let id: Int
    let name: String
    let imageURL: String
    let genres: [GenreDTO]
    
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             imageURL = "background_image",
             genres
    }
}

struct GenreDTO: Decodable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id,
             name
    }
}
// Favorite Model
struct FavoriteDTO: Decodable, Encodable {
    let id: Int
    let name: String
    let genres: String
    let imageData: Data
    
    init(gameDTO: DetailDTO, imageData: Data) {
        self.id = gameDTO.id
        self.name = gameDTO.name
        self.genres = gameDTO.genres.map { $0.name }.joined(separator: ", ")
        self.imageData = imageData
    }
}

// Detail Model
struct DetailDTO: Decodable {
    let id: Int
    let name: String
    let imageLink: String
    let additionalImageLink: String?
    let genres: [GenreDTO]
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
