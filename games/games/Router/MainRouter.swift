//
//  MainRouter.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import UIKit

final class MainRouter {
    let navigationController: UINavigationController = UINavigationController()
    
    private let childRouters: [ChildRouterProtocol]
    private let rootVC: UIViewController
    
    init() {
        let tabController = UITabBarController()
        childRouters = [ ListRouter(), FavoriteRouter() ]
        let navControllers = childRouters.map { $0.navigationController }
        tabController.viewControllers = navControllers
        
        rootVC = tabController
    }
    
    func start() {
        childRouters.forEach { $0.start() }
        app.window.rootViewController = rootVC
    }
}
