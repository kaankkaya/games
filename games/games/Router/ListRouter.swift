//
//  ListRouter.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import UIKit

final class ListRouter: ChildRouterProtocol {
    let navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        return nav
    }()
    
    func start() {
        let initiaVC = ListBuilder.make()
        // Set vc Delegate
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(initiaVC, animated: true)
    }
}
