//
//  LoggerMiddleware.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation
import CoreArchitecture

class LoggerMiddleware: Middleware {
    
    func willProcess(_ action: Action) { }
    
    func didProcess(_ action: Action) {
        print(">", action)
    }
}
