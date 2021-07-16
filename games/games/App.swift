//
//  App.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

let app = App()

final class App {
    
    let window = UIWindow()
    
    let service = GameService()
    
    let router = MainRouter()
    
    func start() {
        window.makeKeyAndVisible()
        router.start()
    }
}
