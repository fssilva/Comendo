//
//  Launcher.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit

class Launcher {
    
    static func launch(with window: UIWindow?) {
        if let nc = window?.rootViewController as? UINavigationController,
            let restaurantListVC = nc.viewControllers.first as? RestaurantListViewController {
            restaurantListVC.component = core.navigationTree.root.value as! RestaurantListComponent
        }
    }
}
