//
//  Map.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation

class Map {
    
    var targets = [Target]()
    var throwables = [String]()
    
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
    
    
    init(currentLevel: Int){
        let json = getJSON("http://ec2-35-162-97-112.us-west-2.compute.amazonaws.com/~Selamawit/Boo/Level\(currentLevel)")
        
        for result in json["Target"].arrayValue{
          
            let type = result["Type"].stringValue
            let pos_x = result["pos_x"].floatValue
            let pos_y = result["pos_y"].floatValue
            
            
            switch type{
            case "Wood" : targets.append(Wood(pos:[pos_x,pos_y]))
                           break
            case "Skeleton": targets.append(Skeleton(pos:[pos_x,pos_y]))
                           break
            case "Vampire": targets.append(Vampire(pos:[pos_x,pos_y]))
                           break
            case "Pumpkin": targets.append(Pumpkin(pos:[pos_x,pos_y]))
                           break
            case "Bat": targets.append(Bat(pos:[pos_x,pos_y]))
                          break
            default: break
                
            }
            
            
        }
        for result in json["Throwable"].arrayValue{
            
            throwables.append(result.string!)
            
            
        }
        

        
        
    }
    
}
