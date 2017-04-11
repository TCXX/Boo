//
//  GameScene.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//
//  http://olivesoft.co.uk/post/Creating-a-slingshot-game-using-Swift-and-SpriteKit/

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var projectile: SKSpriteNode!
    var projectileIsDragged = false
    var touchCurrentPoint: CGPoint!
    var touchStartingPoint :CGPoint!
    
    static let projectileRadius = CGFloat(15.0)
    static let projectileRestPosition = CGPoint(x: 10, y: 10)
    static let projectileTouchThreshold = CGFloat(10)
    static let projectileSnapLimit = CGFloat(10)
    static let forceMultiplier = CGFloat(0.5)
    static let rLimit = CGFloat(50)
    
    static let gravity = CGVector(dx: 0, dy: -9.8)
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.brown
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsWorld.gravity = GameScene.gravity
        physicsWorld.speed = 0.5
        
        setupSlingshot()
        setupBoxes()
    }
    
    func setupSlingshot() {
        
        projectile = SKSpriteNode(imageNamed: "candy.png")
        projectile.position = GameScene.projectileRestPosition
        addChild(projectile)
        
        let slingshot0 = SKSpriteNode(imageNamed: "shot0.png")
        slingshot0.position = GameScene.projectileRestPosition
        addChild(slingshot0)
    }
    
    func setupBoxes() {
        let box = Box(imageNamed: "candy.png")
        box.integrity = 2
        box.position = CGPoint(x: 100, y: 100)
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        addChild(box)
    }
    
    func fingerDistanceFromProjectileRestPosition(_ projectileRestPosition: CGPoint, fingerPosition: CGPoint) -> CGFloat {
        return sqrt(pow(projectileRestPosition.x - fingerPosition.x,2) + pow(projectileRestPosition.y - fingerPosition.y,2))
    }
    
    func projectilePositionForFingerPosition(_ fingerPosition: CGPoint, projectileRestPosition:CGPoint, circleRadius rLimit:CGFloat) -> CGPoint {
        let φ = atan2(fingerPosition.x - projectileRestPosition.x, fingerPosition.y - projectileRestPosition.y)
        let cX = sin(φ) * rLimit
        let cY = cos(φ) * rLimit
        return CGPoint(x: cX + projectileRestPosition.x, y: cY + projectileRestPosition.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        func shouldStartDragging(_ touchLocation:CGPoint, threshold: CGFloat) -> Bool {
            let distance = fingerDistanceFromProjectileRestPosition(
                GameScene.projectileRestPosition,
                fingerPosition: touchLocation
            )
            return distance < GameScene.projectileRadius + threshold
        }
        
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            
            if !projectileIsDragged && shouldStartDragging(touchLocation, threshold: GameScene.projectileTouchThreshold)  {
                touchStartingPoint = touchLocation
                touchCurrentPoint = touchLocation
                projectileIsDragged = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if projectileIsDragged {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let distance = fingerDistanceFromProjectileRestPosition(touchLocation, fingerPosition: touchStartingPoint)
                if distance < GameScene.rLimit  {
                    touchCurrentPoint = touchLocation
                } else {
                    touchCurrentPoint = projectilePositionForFingerPosition(
                        touchLocation,
                        projectileRestPosition: touchStartingPoint,
                        circleRadius: GameScene.rLimit
                    )
                }
                
            }
            projectile.position = touchCurrentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if projectileIsDragged {
            projectileIsDragged = false
            let distance = fingerDistanceFromProjectileRestPosition(touchCurrentPoint, fingerPosition: touchStartingPoint)
            if distance > GameScene.projectileSnapLimit {
                let vectorX = touchStartingPoint.x - touchCurrentPoint.x
                let vectorY = touchStartingPoint.y - touchCurrentPoint.y
                projectile.physicsBody = SKPhysicsBody(circleOfRadius: GameScene.projectileRadius)
                projectile.physicsBody?.applyImpulse(
                    CGVector(
                        dx: vectorX * GameScene.forceMultiplier,
                        dy: vectorY * GameScene.forceMultiplier
                    )
                )
            } else {
                projectile.physicsBody = nil
                projectile.position = GameScene.projectileRestPosition
            }
        }
    }
    
}

class Box: SKSpriteNode {
    var integrity: Int = 2 {
        didSet {
            if integrity > 2 {
                integrity = 2
            }
            if integrity < 0 {
                removeFromParent()
            }
            texture = SKTexture(imageNamed: "box_\(integrity)")
        }
    }
}
