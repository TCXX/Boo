//
//  Game.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class Game {
    
    var level: Level!
   // var myLevel: Int = 0
    
    func setLevel(pickLevel: Int){
        
        //DECIDE NUM OF TARGETS AND THROWABLES FOR LEVEL
           
        //PREPARE THE SCREEN BASED ON LEVEL
            
        level = Level(theLevel: pickLevel)
        

       
    }
    
    func setUp_Screen(currLevel: Level){
        
        
        
        
        
        
        
    }
    
    
    func setUp_Game(){
        
        //what level are we on?
        
        
        //add graphics based on level
        
        
        
    }
    
    func play(){
        
        var start: Int = 1;
        setLevel(pickLevel: start)
    
        setUp_Screen(currLevel: level)
        
        while((level.isPassed() == false) && (level.isFailed() == false)){
            
            
            //check if user uses slingshot
            
            //check for collision
            
            //update screen
            
            //check the number of throwables left, if 0 -> call gameOver
            
            if(level.isFailed()){
                //You failed message here
                //Do you want to replay message here
                //if yes, setLevel(start)
                //if no, quit
            }else if(level.isPassed()){
                //Do you want to continue message here
                //if yes, setLevel(start++)
                //if no, quit
                
                start = start + 1
                
            }
            
            
        }
        
        
        
    }
    
    
    
    func gameOver(){
        //SHOW A RETRY PAGE AND CALL PLAY IF RETRY IS CALLED
        
    }
    
    
    
}


//Used in Map class
class Level{
    
    //villains
    var numWood: Int = 0
    var numVampire: Int = 0
    var numSkeleton: Int = 0
    var numPumpkin: Int = 0
    var numBats: Int = 0
    
    
    //weapons
    var numCandy: Int = 0
    var numMilk: Int = 0
    var numBomb: Int = 0
    
    
    init(theLevel: Int){
    
        switch theLevel {
        case 1 :
            set(theWood: 6, thePumpkin: 3,theVampire: 2,theSkeleton: 2,theBats: 3,theCandy: 1,theMilk: 1,theBomb: 1)
            break
        default:
            break
        }
    }
    
    func set(theWood: Int, thePumpkin: Int, theVampire: Int, theSkeleton: Int, theBats: Int, theCandy: Int, theMilk: Int, theBomb: Int){
        
        numWood = theWood
        numVampire = theVampire
        numSkeleton = theSkeleton
        numPumpkin = thePumpkin
        numBats = theBats
        numCandy = theCandy
        numMilk  = theMilk
        numBomb = theBomb
        
        
        
    }
    
    
    func isPassed() -> Bool{
        
        //checks if the total num of Targets == 0
        if((numBats + numVampire + numSkeleton + numWood + numPumpkin) <= 0){
            return true;
        }
        return false;
    }
    
    
    func isFailed() -> Bool{
        
        //checks if the total num of throwables == 0 but level not passed yet
        if(!isPassed() && ((numMilk + numBomb + numCandy) <= 0)){
            return true;
        }
        
        return false;
    }
    
}
