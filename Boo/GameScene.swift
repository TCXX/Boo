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
    var motionTimer = Timer()
    var delayTimer = Timer()
    
    var dicFindTarget: [SKNode: Target] = [:]
    var dicFindThrowable: [SKNode: Throwable] = [:]
    
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
    static let rLimit = CGFloat(50)
    
    // game constants
    static let targetImages: [String: String] = ["Wood-v": "wood-h.png",
                                                 "Pumpkin": "pumpkin.png",
                                                 "Vampire": "vampire.png"]
    
    static let throwableImages: [String: String] = ["Candy": "candy.png",
                                                    "Milk": "candy.png",
                                                    "Banana": "candy.png"]
    
    // collision constants
    static let throwableCategory: UInt32 = 0x1 << 0
    static let woodCategory: UInt32 = 0x1 << 1
    //static let animalCategory = UInt32(0x1 << 2)
    
    override func didMove(to view: SKView) {
        setBackground()
        setupSlingshot()
        
        currentLevel = 1
        
        let count1 = loadMap(level: currentLevel)
        print ("Target: \(count1) ")
        
        setPhysics()
        
        let count2 = setupProjectile(object: map!.throwables[0])
        print("Throwable: \(count2) ")
    }
    
    func setBackground() {
        let bg = SKSpriteNode(imageNamed: "background1.png")
        bg.zPosition = -100
        addChild(bg)

    }
    
    func setPhysics() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = map!.gravity
        physicsWorld.speed = 1.0
    }
    
    func startTimer () {
        motionTimer.invalidate()
        motionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkIfAtRest), userInfo: nil, repeats: true)
    }
    
    func checkIfAtRest () {
        if projectile == nil{
            return
        } else if projectile!.physicsBody == nil {
            return
        }
        
        if projectile!.physicsBody!.velocity.dx + projectile!.physicsBody!.velocity.dy < 0.01 {
            if (delayTimer.isValid == false) {
                startDelay()
            }
        } else { // still in motion
            delayTimer.invalidate()
        }
    }
    
    func startDelay () {
        delayTimer.invalidate()
        delayTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(nextProjectile), userInfo: nil, repeats: false)
    }
    
    func nextProjectile() -> Int {
        if map == nil {
            print ("map does not exist")
            return 0
        }
        
        if projectile != nil {
            projectile.removeFromParent()
        }
        
        if map!.throwables.isEmpty == false {
           map!.throwables.remove(at: 0)
            if map!.throwables.isEmpty == false {
                return setupProjectile(object: map!.throwables[0])
            } else {
                isFailed()
                return 0
            }
        } else {
            return 0
        }
    }
    
    func setupSlingshot() {
        let slingshot0 = SKSpriteNode(imageNamed: "shot0.png")
        let slingshot1 = SKSpriteNode(imageNamed: "shot1.png")
        
        shotPosition = CGPoint(x: self.frame.origin.x+slingshot0.frame.width*2.333,
                                         y: self.frame.origin.y+slingshot0.frame.height*0.505)
        projectileRestPosition = CGPoint(x: shotPosition.x+20, y: shotPosition.y+60)
        
        slingshot1.position = shotPosition
        slingshot1.zPosition = 10
        addChild(slingshot1)
        
        slingshot0.position = shotPosition
        slingshot0.zPosition = -10
        addChild(slingshot0)
    }
    
    func setupProjectile (object: Throwable) -> Int {
        let type = object.type
        if type == nil {
            return 0
        }
        let image = GameScene.throwableImages[type!.name]
        if (image != nil) {
            projectile = SKSpriteNode(imageNamed: image!)
            projectile.zPosition = 0
            projectileRadius = projectile.frame.width / 2
            projectile.position = projectileRestPosition
            addChild(projectile)
            
            dicFindThrowable.updateValue(object, forKey: projectile)
        } else {
            return 0
        }
        return 1
    }
    
    func loadMap(level: Int) -> Int {
        var count = 0
        map = Map(currentLevel: level)
        for target in map!.targets {
            let type = target.type
            if type == nil {
                continue
            }
            let image = GameScene.targetImages[type!.name]
            if (image != nil) {
                count = count + 1
                let node = SKSpriteNode(imageNamed: image!)
                node.position = target.thePosition
                node.zPosition = -1
                dicFindTarget.updateValue(target, forKey: node)
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody!.categoryBitMask = GameScene.woodCategory
                node.physicsBody!.contactTestBitMask = GameScene.throwableCategory
                addChild(node)
            }
        }
        
        return count
        
    }
    
    func isPassed () {
        motionTimer.invalidate()
        print("Is passed")
    }
    
    func isFailed () {
        motionTimer.invalidate()
        print("Is failed")
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
            let node = secondBody.node!
            let target = dicFindTarget[node]!
            let t = dicFindThrowable[projectile]!
            
            target.decreaseDamageValue(amount: t.hitImpact)
            node.alpha = CGFloat(target.damageValue)/CGFloat(target.maxDamageValue)
            if target.damageValue == 0 {
                node.removeFromParent()
            }
        }
        
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
        if projectile == nil{
            return
        }
        
        func shouldStartDragging(_ touchLocation:CGPoint, threshold: CGFloat) -> Bool {
            if projectile.physicsBody != nil {
                return false
            }
            
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
        if projectile == nil{
            return
        }
        
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
        if projectile == nil{
            return
        }
        
        if projectileIsDragged {
            projectileIsDragged = false
            let distance = fingerDistanceFromProjectileRestPosition(touchCurrentPoint, fingerPosition: touchStartingPoint)
            if distance > GameScene.projectileSnapLimit {
                let vectorX = touchStartingPoint.x - touchCurrentPoint.x
                let vectorY = touchStartingPoint.y - touchCurrentPoint.y
                projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectileRadius)
                projectile.physicsBody!.categoryBitMask = GameScene.throwableCategory
                projectile.physicsBody!.contactTestBitMask = GameScene.woodCategory
                
                startTimer()
                
                let t = dicFindThrowable[projectile]
                if t == nil {
                    return
                }
                projectile.physicsBody!.applyImpulse(
                    CGVector(
                        dx: vectorX * t!.objectSpeed,
                        dy: vectorY * t!.objectSpeed
                    )
                )
            } else {
                projectile.physicsBody = nil
                projectile.position = projectileRestPosition
            }
        }
    }
    
}
