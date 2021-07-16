//
//  DetailContracts.swift
//  games
//
//  Created by Kaan Kaya on 16.07.2021.
//

import UIKit

protocol DetailVMDelegate: AnyObject {
    func handleImage(_ image: UIImage)
    func reloadData()
}
