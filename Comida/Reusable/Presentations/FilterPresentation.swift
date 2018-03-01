//
//  FilterPresentation.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

class FilterPresentation: NSObject {
    
    let name: String
    let prettyName: String
    
    override var description : String {
        return prettyName
    }
    
    init(filter: String) {
        self.name = filter
        self.prettyName = filter.uppercased()
    }
}

func ==(lhs: FilterPresentation, rhs: FilterPresentation) -> Bool {
    return lhs.name == rhs.name && lhs.prettyName == rhs.prettyName
}


