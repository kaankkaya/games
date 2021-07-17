//
//  FavoriteVM.swift
//  games
//
//  Created by Kaan Kaya on 17.07.2021.
//

import Foundation

final class FavoriteVM {
    var favorites = [FavoriteDTO]()
    
    func load() {
        let favoritesData = app.userDefaults.array(forKey: app.userDefaultsKey) as! [Data]
        favorites = favoritesData.compactMap { try? JSONDecoder().decode(FavoriteDTO.self, from: $0) }
    }
   
    func remove(id: Int) {
        favorites.removeAll(where: { $0.id == id })
        let favoritesData = favorites.compactMap { try? JSONEncoder().encode($0) }
        
        app.userDefaults.setValue(favoritesData, forKey: app.userDefaultsKey)
    }
}
