//
//  Map.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class Map {
    
    var vampArray = [Vampire]()
    var skeletonArray = [Skeleton]()
    var batsArray = [Bat]()
    var pumpkinArray = [Pumpkin]()
    var woodArray = [Wood]()
    
    init(theLevel : Level){
        let theVamps = theLevel.numVampire
        for _ in 0..<theVamps{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE. [0, 0] IS JUST A PLACEHOLDER
            //MAYBE USE MATH.RANDOM?
            
            vampArray.append(Vampire(pos: [0,0]))
        }
        
        let thePumps = theLevel.numPumpkin
        for _ in 0..<thePumps{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE. [0, 0] IS JUST A PLACEHOLDER
            //MAYBE USE MATH.RANDOM?
            
            pumpkinArray.append(Pumpkin(pos: [0,0]))
        }
        
        let theBats = theLevel.numBats
        for _ in 0..<theBats{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE. [0, 0] IS JUST A PLACEHOLDER
            //MAYBE USE MATH.RANDOM?
            
            batsArray.append(Bat(pos: [0,0]))
        }
        
        let theWoods = theLevel.numWood
        for _ in 0..<theWoods{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE. [0, 0] IS JUST A PLACEHOLDER
            //MAYBE USE MATH.RANDOM?
            
            woodArray.append(Wood(pos: [0,0]))
        }
        
        let theSkels = theLevel.numSkeleton
        for _ in 0..<theSkels{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE. [0, 0] IS JUST A PLACEHOLDER
            //MAYBE USE MATH.RANDOM?
            
            skeletonArray.append(Skeleton(pos: [0,0]))
        }
        
        
    }
    
}
