//
//  TargetType.swift
//  Boo
//
//  Created by XINYI on 4/13/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class TargetType {
    var name = "Unknown"
    var maxDamageValue: Double = 10
    var mustDestroy = false
    var affectByGravity = false
    
    init (name: String, max: Double, destroy: Bool, gravity: Bool) {
        self.name = name
        maxDamageValue = max
        mustDestroy = destroy
        affectByGravity = gravity
    }
}
