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
    var throwables = [Throwable]()
    
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
            let pos_y = result["pos_Y"].floatValue
            
            //BASED ON WHAT TYPE (IE. SWITCH CASE), CREATE CORRESPONDING SUB-CLASS OF TARTGETS
            
            //targets.append(WOOD(PARAMETERS))

        }
        
        
    }
    
}
