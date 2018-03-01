//
//  ComidaPercistence.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 11.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

class Percistence {
    
    static let shared = Percistence()
    
    private init() {
    }
    
    func favoriteItem(key: String) {
        UserDefaults.standard.set(true, forKey: key)
    }
    
    func unfavoriteItem(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func isItemFavorite(key: String) -> Bool {
        if let _ = UserDefaults.standard.object(forKey: key) {
            return true
        }
        
        return false
    }
}
