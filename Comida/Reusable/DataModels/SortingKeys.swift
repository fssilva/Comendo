//
//  SortingKeys.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

struct SortingKeys : Codable {
    let sortingkeys : [String]?
    
    enum CodingKeys: String, CodingKey {
        case sortingKeys = "sortingKeys"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sortingkeys = try values.decodeIfPresent([String].self, forKey: .sortingKeys)
    }
    
    func encode(to encoder: Encoder) throws {
        // Do nothing
    }
    
}
