//
//  MovieListNavigator.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
import CoreArchitecture

class RestaurantListNavigator: Navigator {
    
    weak var component: RestaurantListComponent?
    
    func resolve(_ action: Action) -> Navigation? {
        guard let component = component, let action = action as? RestaurantListNavigatorAction else { return nil }
        switch action {
        case .detail(let restaurant):
            let navigator = RestaurantDetailsNavigator()
            let newComponent = RestaurantDetailsComponent(restaurant: restaurant, navigator: navigator)
            navigator.component = newComponent
            return BasicNavigation.push(newComponent, from: component)
        }
    }
}
