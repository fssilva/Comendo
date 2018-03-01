//
//  RestaurantService.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

protocol RestaurantsService {
    func fetchRestaurants(_ completion: @escaping ((Result<[Restaurant]>) -> Void))
    func fetchSortingKeys(_ completion: @escaping ((Result<[String]>) -> Void))
}

