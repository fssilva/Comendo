//
//  ComendoDataModel.swift
//  Comendo
//
//  Created by Felipe de Sousa Silva on 08.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
struct ComendoDataModel : Codable {
    let restaurants : [Restaurant]?
    
    enum CodingKeys: String, CodingKey {
        
        case restaurant = "restaurants"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurants = try values.decodeIfPresent([Restaurant].self, forKey: .restaurant)
    }
    
    func encode(to encoder: Encoder) throws {
        //Do nothing
    }
    
}
