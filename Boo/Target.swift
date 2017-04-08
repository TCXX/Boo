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
    
    var hitCalled: Bool = false
    var damageValue: Int = 0
    var maxDamageValue: Int = 0
    var thePosition: [Int] = [0, 0]
    var isDead: Bool = false;
    
    init(damage: Int, lifeValue: Int, pos: [Int]){
        damageValue = damage
        maxDamageValue = lifeValue
        thePosition = pos
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPosition() -> [Int] {
        return thePosition
    }
    
    
    
    func isHit(items: Throwable){
        
        hitCalled = true
        
        //CHECK PHYSICS IN ANOTHER FUNCTION, THEN CALL isHit
        
        if(damageValue > 0){
            damageValue = damageValue - (Int)(items.hitImpact * (Double)(damageValue))
        }
        
        if(damageValue <= 0){
            removeFromParent();
        }
    
    }
}



class Woods: Target {
    var theName: String = ""
    
    var woodDamage: Int = 500
    var woodMax: Int = 500
    
    init(pos: [Int])  {
        
        super.init(damage: woodDamage, lifeValue: woodMax, pos: pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(){
        if(hitCalled){
            
            //update display of score and damage values for wood
            
            hitCalled = false
        }
        
        
        
    }
    
}


class Pumpkins: Target {
    var theName: String = ""
    
    var pumpkinDamage: Int = 100
    var pumpkinMax: Int = 100
    
    init(pos: [Int])  {
        
        super.init(damage: pumpkinDamage, lifeValue: pumpkinMax, pos: pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        
        if(hitCalled){
            
            //update display of score and damage values for pumpkin

            hitCalled = false
        }
        
    }
    
}


class Vampires: Target {
    var theName: String = ""
    
    var vampireDamage: Int = 300
    var vampireMax: Int = 300
    
    init(pos: [Int])  {
        
        super.init(damage: vampireDamage, lifeValue: vampireMax, pos: pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        if(hitCalled){
            
            //update display of score and damage values for vampire
            
            hitCalled = false
        }
        
    }
}


class Skeletons: Target {
    var theName: String = ""
    
    var skeletonDamage: Int = 50
    var skeletonMax: Int = 50
    
    init(pos: [Int])  {
        
        super.init(damage: skeletonDamage, lifeValue: skeletonMax, pos: pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(){
        if(hitCalled){
        
            //update display of score and damage values for skeleton
        
            hitCalled = false
        }
        
    }
    
}


class Bats: Target {
    var theName: String = ""
    var xv: Double = 0.0      //x-velocity
    var yv: Double = 0.0      //y-velocity
    
    var batDamage: Int = 1000
    var batMax: Int = 1000
    
    
    
    init(pos: [Int])  {
        
        super.init(damage: batDamage, lifeValue: batMax, pos: pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func isOnScreen() -> Bool {
        
        //CHECK IF THE OBJECT IS AT THE EDGE OF THE SCREEN, THEN CHANGE THE DIRECTION OF  VELOCITY
        
        return false
    }
    
    func flyBat(thePos: [Int]){
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
        
        if(hitCalled){
            
            //update display of score and damage values for bats
        
            hitCalled = false
        }
        
    }
    
}

