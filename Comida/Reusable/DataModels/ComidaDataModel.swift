//
//  ComidaDataModel.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
struct ComidaDataModel : Codable {
    let restaurants : [Restaurant]?
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "restaurants"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurants = try values.decodeIfPresent([Restaurant].self, forKey: .restaurants)
    }
    
}
