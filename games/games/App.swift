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
    let userDefaults = UserDefaults.standard
    let userDefaultsKey = "favorites"
    
    func start() {
        if userDefaults.value(forKey: userDefaultsKey) == nil {
            userDefaults.setValue([Data](), forKey: userDefaultsKey)
        }
        
        window.makeKeyAndVisible()
        router.start()
    }
}
