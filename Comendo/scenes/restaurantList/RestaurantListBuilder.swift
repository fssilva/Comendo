//
//  RestaurantListBuilder.swift
//  Comendo
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright (c) 2018 Netlight. All rights reserved.
//

import UIKit

struct RestaurantListBuilder {

    static func viewController() -> UIViewController {
        let viewModel = RestaurantListViewModel()
        let router = RestaurantListRouter()
        let viewController = RestaurantListViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
