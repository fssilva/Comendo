//
//  RestaurantDetailsNavigator.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 10.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
import CoreArchitecture

class RestaurantDetailsNavigator: Navigator {
    
    weak var component: RestaurantDetailsComponent?
    
    func resolve(_ action: Action) -> Navigation? {
        guard let component = component, let action = action as? RestaurantDetailsNavigatorAction else { return nil }
        switch action {
    
        case .map(let restaurant):
            // TODO: Navigate to map screen.
            return nil
        }
    }
}
