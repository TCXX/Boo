//
//  GameScene.swift
//  Boo
//
//  Created by XINYI on 4/1/17.
//  Copyright © 2017 Tianxinxin iOS. All rights reserved.
//
//  http://olivesoft.co.uk/post/Creating-a-slingshot-game-using-Swift-and-SpriteKit/

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // game status
    var currentLevel: Int = 0
    var map: Map?
    
    // slingshot status
    var projectile: SKSpriteNode!
    var projectileIsDragged = false
    var touchCurrentPoint: CGPoint!
    var touchStartingPoint :CGPoint!
    
    // slingshot constants
    var projectileRadius = CGFloat(15.0)
    var projectileRestPosition = CGPoint(x:0, y:0)
    var shotPosition = CGPoint(x: 0, y: 0)
    
    static let projectileTouchThreshold = CGFloat(10)
    static let projectileSnapLimit = CGFloat(10)
    static let forceMultiplier = CGFloat(2.5)
    static let rLimit = CGFloat(50)
    
    // game constants
    static let gravity = CGVector(dx: 0, dy: -8)
    
    static let targetImages: [String: String] = ["Wood-v": "wood-h.png",
                                                 "Pumpkin": "pumpkin.png",
                                                 "Vampire": "vampire.png"]
    
    // collision constants
    static let throwableCategory: UInt32 = 0x1 << 0
    static let woodCategory: UInt32 = 0x1 << 1
    //static let animalCategory = UInt32(0x1 << 2)
    
    override func didMove(to view: SKView) {
        setBackground()
        setupSlingshot()
        currentLevel = 1
        loadMap(level: currentLevel)
        setPhysics()
    }
    
    func setBackground() {
        let bg = SKSpriteNode(imageNamed: "background1.png")
        addChild(bg)

    }
    
    func setPhysics() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = GameScene.gravity
        physicsWorld.speed = 1.0
    }
    
    func setupSlingshot() {
        let slingshot0 = SKSpriteNode(imageNamed: "shot0.png")
        let slingshot1 = SKSpriteNode(imageNamed: "shot1.png")
        projectile = SKSpriteNode(imageNamed: "candy.png")
        
        shotPosition = CGPoint(x: self.frame.origin.x+slingshot0.frame.width*2.333,
                                         y: self.frame.origin.y+slingshot0.frame.height*0.505)
        projectileRestPosition = CGPoint(x: shotPosition.x+20, y: shotPosition.y+60)
        slingshot1.position = shotPosition
        addChild(slingshot0)
        
        projectileRadius = projectile.frame.width / 2
        projectile.position = projectileRestPosition
        addChild(projectile)
        
        slingshot0.position = shotPosition
        addChild(slingshot1)
    }
    
    func loadMap(level: Int) {
        map = Map(currentLevel: level)
        for target in map!.targets {
            let image = GameScene.targetImages[target.type]
            if (image != nil) {
                let node = SKSpriteNode(imageNamed: image!)
                node.position = target.getPosition()
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody!.categoryBitMask = GameScene.woodCategory
                node.physicsBody!.contactTestBitMask = GameScene.throwableCategory
                addChild(node)
            }
        }
        
    }
    
    // https://www.raywenderlich.com/123393/how-to-create-a-breakout-game-with-sprite-kit-and-swift
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if firstBody.categoryBitMask == GameScene.throwableCategory && secondBody.categoryBitMask == GameScene.woodCategory {
            print(firstBody)
        }
        print("Something hit")
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
                projectileRestPosition,
                fingerPosition: touchLocation
            )
            return distance < projectileRadius + threshold
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
                projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectileRadius)
                projectile.physicsBody!.categoryBitMask = GameScene.throwableCategory
                projectile.physicsBody!.contactTestBitMask = GameScene.woodCategory
                projectile.physicsBody!.applyImpulse(
                    CGVector(
                        dx: vectorX * GameScene.forceMultiplier,
                        dy: vectorY * GameScene.forceMultiplier
                    )
                )
            } else {
                projectile.physicsBody = nil
                projectile.position = projectileRestPosition
            }
        }
    }
    
}
