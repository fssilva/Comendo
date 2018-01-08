//
//  RestaurantDetailsBuilder.swift
//  Comendo
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright (c) 2018 Netlight. All rights reserved.
//

import UIKit

struct RestaurantDetailsBuilder {

    static func viewController(withRestID restID: String) -> UIViewController {
        let viewModel = RestaurantDetailsViewModel()
        let router = RestaurantDetailsRouter()
        let viewController = RestaurantDetailsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
