//
//  RestaurantSortingProtocol.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 10.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

protocol RestaurantSortingProtocol {
    static func sorting(withKey key: String?, restaurants: [Restaurant]) -> [Restaurant]
}

class RestaurantSorting: RestaurantSortingProtocol {
    
    // Priorities goes from right to left. The higher priority is called at the end of the chain.
    // Key -> Status -> Favorite
    static func sorting(withKey key: String?, restaurants: [Restaurant]) -> [Restaurant] {
        
        if let k = key {
            return restaurants.sorted(by: { (rest1, rest2) in
                return rest1.compareWith(SortingValues.CodingKeys(rawValue: k)!, rest2)
            }).sorted(by: statusSort).sorted(by: favoriteSort)
        }else {
            return restaurants.sorted(by: statusSort).sorted(by: favoriteSort)
        }
    }
    
    fileprivate static func statusSort(left:Restaurant, right:Restaurant) -> Bool {
         return getScoreForStatus(left.status!) < getScoreForStatus(right.status!)
    }
    
    fileprivate static func favoriteSort(left:Restaurant, right:Restaurant) -> Bool {
        return left.isFavorite && !right.isFavorite
    }
    
    fileprivate static func getScoreForStatus(_ status: String) -> Int {
        switch status {
        case "open":
            return 0;
        case "order ahead":
            return 1;
        case "closed":
            return 2;
        default:
            return 99999
        }
    }
}
