//
//  RestaurantPresentation.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

class RestaurantPresentation: NSObject {
    
    let name: String
    let status: String
    let sortingValues: SortingValues // Could also be a presentation. Maybe too much overhead ?

    let isFavorite: Bool // Local property
    
    
    init(restaurant: Restaurant) {
        self.name = restaurant.name!
        self.status = restaurant.status!
        self.sortingValues = restaurant.sortingValues!
        self.isFavorite = restaurant.isFavorite
    }
    
}
