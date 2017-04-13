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
    var maxDamageValue = 10
    var mustDestroy = false
    var affectByGravity = false
    
    init (name: String, max: Int, destroy: Bool, gravity: Bool) {
        self.name = name
        maxDamageValue = max
        mustDestroy = destroy
        affectByGravity = gravity
    }
}
