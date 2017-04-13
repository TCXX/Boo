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
    
    enum targetType{
        case wood_h
        case wood_v
        case vampire
        case pumpkin
        case bat
        case unknown
    }
    
    static let dicFindType: [String: targetType] = ["Wood-h": .wood_h,
                                                    "Wood-v": .wood_v,
                                                    "Vampire": .vampire,
                                                    "Pumpkin": .pumpkin,
                                                    "Bat": .bat]
    
    //var hitCalled: Bool = false
    var type: targetType = .unknown
    var damageValue: Int = 0
    var maxDamageValue: Int = 0
    var thePosition = CGPoint(x: 0, y: 0)
    
    init(type: String, damage: Int, maxDamage: Int, pos: CGPoint){
        super.init(texture: nil, color: UIColor.clear, size: CGSize.init(width: 0.3, height: 0.3))
        
        self.type = convertType(str: type)
        damageValue = damage
        maxDamageValue = maxDamage
        thePosition = pos
    }
    
    required init?(coder aDecoder: NSCoder) {
       // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func decreaseDamageValue (amount: Int) {
        if damageValue > amount {
            damageValue = damageValue - amount
        } else {
            damageValue = 0
        }
    }
    
    func getPosition() -> CGPoint {
        return thePosition
    }
    
    private func convertType (str: String) -> targetType {
        let t = Target.dicFindType[str]
        if t == nil {
            return .unknown
        }
        return t!
    }
    
    func isHit(items: Throwable){
        
        //hitCalled = true
        
        //CHECK PHYSICS IN ANOTHER FUNCTION, THEN CALL isHit
        
        if(damageValue > 0){
            damageValue = damageValue - (Int)(items.hitImpact * (Double)(damageValue))
        }
        
        if(damageValue <= 0){
            removeFromParent();
        }
    
    }
}


class Bat: Target {
  //  var theName: String = ""
    var xv: Double = 0.0      //x-velocity
    var yv: Double = 0.0      //y-velocity
    
    var batDamage: Int = 1000
    var batMax: Int = 1000
    
    
    init(pos: CGPoint)  {
        
        super.init(type: "Bat", damage: batDamage, maxDamage: batMax, pos: pos)
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
        
        //if(hitCalled){
            
            //update display of score and damage values for bats
        
            //hitCalled = false
        //}
        
    }
    
}

