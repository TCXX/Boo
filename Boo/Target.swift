//
//  Target.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Target: SKSpriteNode{

    static let dicFindType: [String: TargetType] =
        ["Wood-h": TargetType.init(name: "Wood-h", max: 2, destroy: false, gravity: false),
         "Wood-v": TargetType.init(name: "Wood-v", max: 2, destroy: false, gravity: false),
         "Vampire": TargetType.init(name: "Vampire", max: 4, destroy: true, gravity: false),
         "Pumpkin": TargetType.init(name: "Pumpkin", max: 3, destroy: true, gravity: false),
         "Bat": TargetType.init(name: "Bat", max: 10, destroy: true, gravity: true),
         "Square": TargetType.init(name: "Square", max: 2, destroy: true, gravity: false),
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


class Bat: Target {
  //  var theName: String = ""
    var xv: Double = 0.0      //x-velocity
    var yv: Double = 0.0      //y-velocity
    
    var batDamage: Int = 1000
    var batMax: Int = 1000
    
    
    init(pos: CGPoint)  {
        
        super.init(type: "Bat", pos: pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func isOnScreen() -> Bool {
        
        //CHECK IF THE OBJECT IS AT THE EDGE OF THE SCREEN, THEN CHANGE THE DIRECTION OF  VELOCITY
        
        return false
    }
    
    func flyBat(thePos: CGPoint){
        while(isOnScreen()){
            
            //DO MULTIPLE DRAWS FOR ANIMATION
            
        }
        
    }
    
    func flyingAnimation(){
        if(isOnScreen()){
           
            flyBat(thePos: thePosition)
            
            
        }else{
            xv = -xv
            yv = -yv
            flyBat(thePos: thePosition)
        }
        
        
    }
    
    func update(){
        
        /*if(hitCalled){
            
            update display of score and damage values for bats
        
            hitCalled = false
        }*/
        
    }
    
}

