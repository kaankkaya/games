//
//  ChildRouterProtocol.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import UIKit

protocol ChildRouterProtocol: RouterProtocol {
    var navigationController: UINavigationController { get }
}
