//
//  Target.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit


class Target {
    
    var hitCalled: Bool = false
    var damageValue: Int = 0
    var maxDamageValue: Int = 0
    var position: [Int] = [0, 0]
    
    init(damage: Int, lifeValue: Int, pos: [Int]){
        damageValue = damage
        maxDamageValue = lifeValue
        position = pos
        
    }
    
    func getPosition() -> [Int] {
        return position
    }
    
    
    func isDead() {
        
        //MAKE TARGET DISAPPEAR FROM SCREEN (WITH A CLOUD OF SMOKE)
        
    }
    
    func isHit(items: Throwable){
        
        hitCalled = true
        
        //CHECK PHYSICS IN ANOTHER FUNCTION, THEN CALL isHit
        
        if(damageValue > 0){
            damageValue = damageValue - (Int)(items.hitImpact * (Double)(damageValue))
        }
        
        if(damageValue <= 0){
            self.isDead();
        }
    
    }
}



class Woods: Target {
    var name: String = ""
    
    var woodDamage: Int = 500
    var woodMax: Int = 500
    
    init(pos: [Int])  {
        
        super.init(damage: woodDamage, lifeValue: woodMax, pos: pos)
    }
    
    
    func update(){
        if(hitCalled){
            
            //update display of score and damage values for wood
            
            hitCalled = false
        }
        
        
        
    }
    
}


class Pumpkins: Target {
    var name: String = ""
    
    var pumpkinDamage: Int = 100
    var pumpkinMax: Int = 100
    
    init(pos: [Int])  {
        
        super.init(damage: pumpkinDamage, lifeValue: pumpkinMax, pos: pos)
    }
    
    func update(){
        
        if(hitCalled){
            
            //update display of score and damage values for pumpkin

            hitCalled = false
        }
        
    }
    
}


class Vampires: Target {
    var name: String = ""
    
    var vampireDamage: Int = 300
    var vampireMax: Int = 300
    
    init(pos: [Int])  {
        
        super.init(damage: vampireDamage, lifeValue: vampireMax, pos: pos)
    }
    
    func update(){
        if(hitCalled){
            
            //update display of score and damage values for vampire
            
            hitCalled = false
        }
        
    }
}


class Skeletons: Target {
    var name: String = ""
    
    var skeletonDamage: Int = 50
    var skeletonMax: Int = 50
    
    init(pos: [Int])  {
        
        super.init(damage: skeletonDamage, lifeValue: skeletonMax, pos: pos)
    }
    
    
    func update(){
        if(hitCalled){
        
            //update display of score and damage values for skeleton
        
            hitCalled = false
        }
        
    }
    
}


class Bats: Target {
    var name: String = ""
    var xv: Double = 0.0      //x-velocity
    var yv: Double = 0.0      //y-velocity
    
    var batDamage: Int = 1000
    var batMax: Int = 1000
    
    
    
    init(pos: [Int])  {
        
        super.init(damage: batDamage, lifeValue: batMax, pos: pos)
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
           
            flyBat(thePos: position)
            
            
        }else{
            xv = -xv
            yv = -yv
            flyBat(thePos: position)
        }
        
        
        
    }
    
    func update(){
        
        if(hitCalled){
            
            //update display of score and damage values for bats
        
            hitCalled = false
        }
        
    }
    
}

