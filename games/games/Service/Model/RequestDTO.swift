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
    
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             imageURL = "background_image"
    }
}
