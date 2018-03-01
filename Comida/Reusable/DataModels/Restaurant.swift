//
//  Restaurant.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

import Foundation
struct Restaurant : Codable, Equatable {
    let name : String?
    let status : String?
    let sortingValues : SortingValues?
    
    var isFavorite: Bool { // Local property
        get {
            return Percistence.shared.isItemFavorite(key: self.name!)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case status = "status"
        case sortingValues = "sortingValues"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.status = try values.decodeIfPresent(String.self, forKey: .status)
        self.sortingValues = try values.decodeIfPresent(SortingValues.self, forKey: .sortingValues)
    }
    
    init(name: String, status: String, sortingValues: SortingValues) {
        self.name = name
        self.status = status
        self.sortingValues = sortingValues
    }
    
    func encode(to encoder: Encoder) throws {
        //Implement if we will persist the model locally.
    }
    
    func compareWith(_ key: SortingValues.CodingKeys, _ other: Restaurant) -> Bool {
        switch key {
        case SortingValues.CodingKeys.bestMatch:
            return self.sortingValues!.bestMatch! > other.sortingValues!.bestMatch!
        case SortingValues.CodingKeys.newest:
            return self.sortingValues!.newest! > other.sortingValues!.newest!
        case SortingValues.CodingKeys.ratingAverage:
            return self.sortingValues!.ratingAverage! > other.sortingValues!.ratingAverage!
        case SortingValues.CodingKeys.distance:
            return self.sortingValues!.distance! < other.sortingValues!.distance!
        case SortingValues.CodingKeys.popularity:
            return self.sortingValues!.popularity! > other.sortingValues!.popularity!
        case SortingValues.CodingKeys.averageProductPrice:
            return self.sortingValues!.averageProductPrice! < other.sortingValues!.averageProductPrice!
        case SortingValues.CodingKeys.deliveryCosts:
            return self.sortingValues!.deliveryCosts! < other.sortingValues!.deliveryCosts!
        case SortingValues.CodingKeys.minCost:
            return self.sortingValues!.minCost! < other.sortingValues!.minCost!
        }
    }
    
}


func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
    return lhs.name == rhs.name && lhs.status == rhs.status
}

