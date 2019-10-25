//
//  Target.swift
//  Boo
//
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Target: SKSpriteNode{

    static let dicFindType: [String: TargetType] =

        ["Wood-h": TargetType.init(name: "Wood-h", max: 2, destroy: false, gravity: true),
         "Wood-v": TargetType.init(name: "Wood-v", max: 2, destroy: false, gravity: true),
         "Vampire": TargetType.init(name: "Vampire", max: 4, destroy: true, gravity: false),
         "Pumpkin": TargetType.init(name: "Pumpkin", max: 3, destroy: true, gravity: true),
         "Bat": TargetType.init(name: "Bat", max: 10, destroy: true, gravity: false),
         "Square": TargetType.init(name: "Square", max: 2, destroy: false, gravity: true),
         "Ghost": TargetType.init(name: "Ghost", max: 4, destroy: true, gravity: false)]

    
    var type: TargetType? = nil
    var damageValue: Double = 0
    var maxDamageValue: Double = 0
    var thePosition = CGPoint(x: 0, y: 0)
    
    init(type: String, pos: CGPoint){
        super.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 0.3, height: 0.3))
        
        self.type = convertType(str: type)
        thePosition = pos
        
        if (self.type != nil) {
            let t = self.type!
            maxDamageValue = t.maxDamageValue
            damageValue = maxDamageValue
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func decreaseDamageValue (amount: Double) {
        if damageValue > amount {
            damageValue = damageValue - amount
        } else {
            damageValue = 0
        }
    }
    
    private func convertType (str: String) -> TargetType? {
        let t = Target.dicFindType[str]
        if t == nil {
            return nil
        }
        return t!
    }
}
