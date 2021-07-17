//
//  FavoriteRouter.swift
//  games
//
//  Created by Kaan Kaya on 17.07.2021.
//

import UIKit

final class FavoriteRouter: ChildRouterProtocol {
    let navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return nav
    }()
    
    func start() {
        let initiaVC = FavoriteBuilder.make()
        // Set vc Delegate
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(initiaVC, animated: true)
    }
}
