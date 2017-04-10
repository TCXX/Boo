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
    
    func getJSON(_ url:String) -> JSON{
        if let url = URL(string:url){
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                return json
            }else{
                return JSON.null
            }
        }else{
            return JSON.null
        }
    }
    
    init(theLevel : Level){
        let theVamps = theLevel.numVampire
        for i in 0..<theVamps{
            let json = getJSON("http://ec2-35-162-97-112.us-west-2.compute.amazonaws.com/~Selamawit/Boo/Level1")
            let dict = json["Target"]
            let array = dict["Vampire\(i)"]
           
             let pos_x = array["pos_x"]
             let pos_y = array["pos_y"]
           
            vampArray.append(Vampire(pos: [pos_x,pos_y]))
        }
        
        let thePumps = theLevel.numPumpkin
        for _ in 0..<thePumps{
            
            let json = getJSON("http://ec2-35-162-97-112.us-west-2.compute.amazonaws.com/~Selamawit/Boo/Level1")
            let dict = json["Target"]
            let array = dict["Pumpkin\(i)"]
            
            let pos_x = array["pos_x"]
            let pos_y = array["pos_y"]
            
            
            pumpkinArray.append(Pumpkin(pos: [pos_x,pos_y]))
        }
        
        let theBats = theLevel.numBats
        for _ in 0..<theBats{
            
            let json = getJSON("http://ec2-35-162-97-112.us-west-2.compute.amazonaws.com/~Selamawit/Boo/Level1")
            let dict = json["Target"]
            let array = dict["Bat\(i)"]
            
            let pos_x = array["pos_x"]
            let pos_y = array["pos_y"]
            
            
            batsArray.append(Bat(pos: [pos_x,pos_y]))
        }
        
        let theWoods = theLevel.numWood
        for _ in 0..<theWoods{
            
            let json = getJSON("http://ec2-35-162-97-112.us-west-2.compute.amazonaws.com/~Selamawit/Boo/Level1")
            let dict = json["Target"]
            let array = dict["Wood\(i)"]
            
            let pos_x = array["pos_x"]
            let pos_y = array["pos_y"]
            
            woodArray.append(Wood(pos: [pos_x,pos_y]))
        }
        
        let theSkels = theLevel.numSkeleton
        for _ in 0..<theSkels{
            
            let json = getJSON("http://ec2-35-162-97-112.us-west-2.compute.amazonaws.com/~Selamawit/Boo/Level1")
            let dict = json["Target"]
            let array = dict["Skeleton\(i)"]
            
            let pos_x = array["pos_x"]
            let pos_y = array["pos_y"]
            
            
            skeletonArray.append(Skeleton(pos: [pos_x,pos_y]))
        }
        
        
    }
    
}
