//
//  Throwable.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Throwable: SKSpriteNode {
    
    var type: ThrowableType? = nil
    var objectSpeed: CGFloat = 0// speed of the throwable
    var hitImpact: Double = 0 //how much damage does the object have
    var affectedByGravity = true
    
    static let dicFindType: [String: ThrowableType] =
        ["Candy": ThrowableType.init(name: "Candy", speed: 2.5, hit: 0.2, gravity: true),
         "Milk": ThrowableType.init(name: "Milk", speed: 3.0, hit: 0.6, gravity: true),
         "Banana": ThrowableType.init(name: "Banana", speed: 3.5, hit: 1.8, gravity: true)]
    
    init(type: String) {
        super.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 0.3, height: 0.3))
        
        self.type = convertType(str: type)
        
        if (self.type != nil) {
            let t = self.type!
            objectSpeed = t.speed
            hitImpact = t.hitImpact
            affectedByGravity = t.affectByGravity
        }
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size) //set container for the throwable object
        self.physicsBody?.affectedByGravity = affectedByGravity //Bc subject to gravity, throwable object can fall
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func convertType (str: String) -> ThrowableType? {
        let t = Throwable.dicFindType[str]
        if t == nil {
            return nil
        }
        return t!
    }
    
}
