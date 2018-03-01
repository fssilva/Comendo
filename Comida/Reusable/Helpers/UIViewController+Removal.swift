//
//  UIViewController+Removal.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var zap_isBeingRemoved: Bool {
        return (navigationController?.isBeingDismissed ?? false) || isBeingDismissed || isMovingFromParentViewController
    }
}
