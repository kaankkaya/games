//
//  ListContracts.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

protocol ListVMDelegate: AnyObject {
    func handle(models: [GamePresentation], page: Int)
    func handle(image: UIImage, for id: Int)
}
