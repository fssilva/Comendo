//
//  ActivityTracker.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import UIKit

struct ActivityTracker: Equatable {
    
    private(set) var activityCount: UInt = 0
    private(set) var needsUpdate = false
    
    var isActive: Bool {
        return activityCount > 0
    }
    
    mutating func addActivity() {
        needsUpdate = (activityCount == 0)
        activityCount += 1
    }
    
    mutating func removeActivity() {
        guard activityCount > 0 else {
            return
        }
        activityCount -= 1
        needsUpdate = (activityCount == 0)
    }
    
    mutating func reset() {
        activityCount = 0
        needsUpdate = false
    }
}

func ==(lhs: ActivityTracker, rhs: ActivityTracker) -> Bool {
    return lhs.needsUpdate == rhs.needsUpdate && lhs.activityCount == rhs.activityCount
}

