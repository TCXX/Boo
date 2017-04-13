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
    
}
