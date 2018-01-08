//
//  RestaurantListRouter.swift
//  Comendo
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright (c) 2018 Netlight. All rights reserved.
//

import Foundation

class RestaurantListRouter {
    weak var viewController: RestaurantListViewController?

    func navigateToDetails(withRestID restID: String) {
        let detailsViewController = RestaurantDetailsBuilder.viewController(withRestID: restID)
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
