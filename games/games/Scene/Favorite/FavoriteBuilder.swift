//
//  FavoriteBuilder.swift
//  games
//
//  Created by Kaan Kaya on 17.07.2021.
//

import UIKit

final class FavoriteBuilder {
    static func make() -> FavoriteVC {
        let vc = UIStoryboard.init(name: "Favorite", bundle: nil).instantiateInitialViewController() as! FavoriteVC
        vc.vm = FavoriteVM()
        vc.title = "Favorites"
        
        return vc
    }
}
