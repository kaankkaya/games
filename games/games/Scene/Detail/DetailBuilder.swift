//
//  DetailBuilder.swift
//  games
//
//  Created by Kaan Kaya on 13.07.2021.
//

import UIKit

final class DetailBuilder {
    static func makeWith(_ id: Int, title: String) -> DetailVC {
        let vc = UIStoryboard.init(name: "Detail", bundle: nil).instantiateInitialViewController() as! DetailVC
        vc.title = title
        
        vc.vm = DetailVM(id: id)
        
        return vc
    }
}
