//
//  Throwable.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Throwable: SKSpriteNode {
    
    private var coordinates: [Double] = [0,0] //position of the throwable
    private var objectSpeed:Int = 10 // speed of the throwable
    var hitImpact:Double = 0.2 //how much damage does the object have
    var image: String = "" //image of the throwable to know what hitvalue to assign
    var path: CGPath? = nil //path that throwable object with go in
    
     init(pos: [Double],sd: Int, object: String) {
        let texture = SKTexture(imageNamed: object)
        super.init(texture: texture, color: UIColor.clear, size: CGSize.init(width: 0.3, height: 0.3))
        
        coordinates = pos
        objectSpeed = sd
        image = object
        
        switch(object) {
            case "candy":
                hitImpact = 0.2
                break
            case "milk":
                hitImpact = 0.4
                break
            case "bomb":
                hitImpact = 0.9
                break
        default: break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getPosition() -> [Double] {
        return coordinates
    }
    
    
    func setPosition(x: Double, y: Double) {
        let values = [x,y]
        
        coordinates = values
    }
    
    func throwObject(ph: UIBezierPath) { //actual throwing with occur in main Game Scene class (using touches)
        self.path = ph.cgPath
    }
    
}
