//
//  ThrowableType.swift
//  Boo
//
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit

class ThrowableType {
    var name = "Unknown"
    var hitImpact: Double = 0
    var speed: CGFloat = 1.0
    var affectByGravity = true
    
    init (name: String, speed: CGFloat, hit: Double, gravity: Bool) {
        self.name = name
        self.speed = speed
        hitImpact = hit
        affectByGravity = gravity
    }
}
