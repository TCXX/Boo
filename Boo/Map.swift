//
//  Map.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit

class Map {
    
    var targets = [Target]()
    var throwables = [Throwable]()
    
    var gravity = CGVector(dx: 0, dy: -8)
    
    // SwiftyJSON helper function
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
    
    // get level info from AWS
   init(currentLevel: Int){

        let json = getJSON("http://ec2-35-162-97-112.us-west-2.compute.amazonaws.com/~Selamawit/Boo/WorkingLevels/L\(currentLevel)")
        
        if json == JSON.null {
            randomCreate(hardness: currentLevel)
        }


        for result in json["Target"].arrayValue{
          
            let type = result["Type"].stringValue
            let pos_x = result["pos_x"].doubleValue
            let pos_y = result["pos_y"].doubleValue
            let pos = CGPoint(x: pos_x, y: pos_y)
            
            targets.append(Target(type: type, pos: pos))
                
        }
        for result in json["Throwable"].arrayValue{
            if (result.string != nil) {
                throwables.append(Throwable(type: result.string!))
            }

        }
        
    }
    
    func randomCreate(hardness: Int) {
        let group1 = ["Candy", "Candy", "Candy", "Candy", "Banana", "Milk"]
        let group2 = ["Wood-v", "Wood-h", "Square", "Square", "Square"]
        let group3 = ["Vampire", "Ghost", "Bat", "Pumpkin", "Pumpkin", "Pumpkin", "Pumpkin"]
        
        for _ in 0...hardness/4 + 3 {
            let type = arc4random_uniform(UInt32(group1.count))
            throwables.append(Throwable(type: group1[Int(type)]))
        }
        
        for _ in 0...hardness/3 + 4 {
            let type = arc4random_uniform(UInt32(group2.count))
            let pos_x = arc4random_uniform(600)
            let pos_y = arc4random_uniform(300)
            targets.append(Target(type: group2[Int(type)], pos: CGPoint(x: Int(pos_x), y: Int(pos_y))))
        }
        
        for _ in 0...hardness/2 + 2 {
            let type = arc4random_uniform(UInt32(group3.count))
            let pos_x = arc4random_uniform(500)
            let pos_y = arc4random_uniform(300)
            targets.append(Target(type: group3[Int(type)], pos: CGPoint(x: Int(pos_x), y: Int(pos_y))))
        }
        
        print ("random level created! ")
    }
    
}
