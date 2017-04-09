//
//  Map.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class Map {
    
    var vampArray: [Vampire] = []
    var skeletonArray: [Skeleton] = []
    var batsArray: [Bat] = []
    var pumpkinArray: [Pumpkin] = []
    var woodArray: [Wood] = []
    
    init(theLevel : Level){
        let theVamps = theLevel.numVampire
        for i in 0..<theVamps{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE
            
            vampArray[i] = Vampire(pos: [0,0])
        }
        
        let thePumps = theLevel.numPumpkin
        for i in 0..<thePumps{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE

            pumpkinArray[i] = Pumpkin(pos: [0,0])
        }
        
        let theBats = theLevel.numBats
        for i in 0..<theBats{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE

            batsArray[i] = Bat(pos: [0,0])
        }
        
        let theWoods = theLevel.numWood
        for i in 0..<theWoods{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE

            woodArray[i] = Wood(pos: [0,0])
        }
        
        let theSkels = theLevel.numSkeleton
        for i in 0..<theSkels{
            
            //SET THE POSITION COORDINATES FOR EACH OF THESE

            skeletonArray[i] = Skeleton(pos: [0,0])
        }
        
        
    }
    
}
