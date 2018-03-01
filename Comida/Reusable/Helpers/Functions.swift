//
//  Functions.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

func executeInMock(afterDelay delay: TimeInterval?, block: @escaping () -> Void) {
    if let delay = delay {
        let deadline = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            block()
        }
    } else {
        block()
    }
}
