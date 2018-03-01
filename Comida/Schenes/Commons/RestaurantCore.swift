//
//  RestaurantCore.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit
import CoreArchitecture

let core: Core = {
    let navigator = RestaurantListNavigator()
    let restaurantComponent = RestaurantListComponent(
        service: MockRestaurantsService(),
        navigator: navigator
    )
    navigator.component = restaurantComponent
    return Core(
        rootComponent: restaurantComponent,
        middlewares: [LoggerMiddleware()]
    )
}()
