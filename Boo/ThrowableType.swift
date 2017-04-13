//
//  ThrowableType.swift
//  Boo
//
//  Created by XINYI on 4/13/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit

class ThrowableType {
    var name = "Unknown"
    var hitImpact = 0
    var speed: CGFloat = 1.0
    var affectByGravity = true
    
    init (name: String, speed: CGFloat, hit: Int, gravity: Bool) {
        self.name = name
        self.speed = speed
        hitImpact = hit
        affectByGravity = gravity
    }
}
