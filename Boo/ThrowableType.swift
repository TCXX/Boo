//
//  ThrowableType.swift
//  Boo
//
//  Created by XINYI on 4/13/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class ThrowableType {
    var name = "Unknown"
    var hitImpact = 0
    var affectByGravity = true
    
    init (name: String, hit: Int, gravity: Bool) {
        self.name = name
        hitImpact = hit
        affectByGravity = gravity
    }
}
