//
//  ListBuilder.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

final class ListBuilder {
    static func make() -> ListVC {
        let vc = UIStoryboard.init(name: "List", bundle: nil).instantiateInitialViewController() as! ListVC
        vc.vm = ListVM()
        
        return vc
    }
}
