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
    
    func isHit() -> Bool {
        
        //add some physics
        
        return false;
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
        
        if (isHit()){
            
            woodDamage = woodDamage - (Int)(0.20 * (Double)(woodDamage))
            
        }
        
        
    }
    
}


class Pumpkins: Target {
    var name: String = ""
    
    var woodDamage: Int = 500
    var woodMax: Int = 500
    
    init(pos: [Int])  {
        
        super.init(damage: woodDamage, lifeValue: woodMax, pos: pos)
    }
    
    
}


class Vampires: Target {
    var name: String = ""
    
    var woodDamage: Int = 500
    var woodMax: Int = 500
    
    init(pos: [Int])  {
        
        super.init(damage: woodDamage, lifeValue: woodMax, pos: pos)
    }
    
    
}


class Skeletons: Target {
    var name: String = ""
    
    var woodDamage: Int = 500
    var woodMax: Int = 500
    
    init(pos: [Int])  {
        
        super.init(damage: woodDamage, lifeValue: woodMax, pos: pos)
    }
    
    
}



class Animated{
    var xv: Double = 0.0      //x-velocity
    var yv: Double = 0.0      //y-velocity
    
    
    func isOnScreen() -> Bool {
        
        //CHECK IF THE OBJECT IS AT THE EDGE OF THE SCREEN, THEN CHANGE THE DIRECTION OF  VELOCITY
        
        return false
    }
    
    
}


class Bats: Target {
    var name: String = ""
    
    var woodDamage: Int = 500
    var woodMax: Int = 500
    
    init(pos: [Int])  {
        
        super.init(damage: woodDamage, lifeValue: woodMax, pos: pos)
    }
    
    
}

