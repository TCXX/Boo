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
    var gameStarted = false
    var map: Map?
    
    // game timers
    var motionTimer = Timer()
    var delayTimer = Timer()
    
    // layers
    let bgLayer = SKSpriteNode()
    let mainLayer = SKSpriteNode()
    let scoreLayer = SKSpriteNode()
    let hintLayer = SKSpriteNode()
    
    // manage SKNodes with corresponding models
    var throwableNodes: [SKNode] = []
    var targetNodes: [SKNode] = []
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
    
    //user stats 
    //var totalScore = 0; /**Add scores to screen**/
    var numLives = 3;
    
    
    // match types with graphics components
    static let targetImages: [String: String] = ["Wood-v": "wood-v.png",
                                                 "Wood-h": "wood-h.png",
                                                 "Pumpkin": "pumpkin.png",
                                                 "Vampire": "vampire.png",
                                                 "Bat": "bat.png",
                                                 "Square": "square.png",
                                                 "Ghost": "ghost.png"]
    
    static let throwableImages: [String: String] = ["Candy": "candy.png",
                                                    "Milk": "milk.png",
                                                    "Banana": "banana.png"]
    
    // collision constants
    static let throwableCategory: UInt32 = 0x1 << 0
    static let woodCategory: UInt32 = 0x1 << 1
    
    
    // load when the app starts
    override func didMove(to view: SKView) {
        
        // set up contexts
        addChild(bgLayer)
        addChild(mainLayer)
        addChild(scoreLayer)
        addChild(hintLayer)
        hintLayer.zPosition = 100
        
        setBackground()
        setupSlingshot()
        
        //specify current level
        currentLevel = 1
        
        startGame()
    }
    
    func startGame() {
        hintLayer.removeAllChildren()

        let count1 = loadMap(level: currentLevel)
        print ("Target: \(count1) ")
        
        if count1 > 0 {
            // set up the physics world with gravity
            setPhysics()
            
            // load the first throwable of level 1
            let count2 = setupProjectile(object: map!.throwables[0])
            print("Throwable: \(count2) ")
            
            gameStarted = true
            
        } else {
            gameStarted = false
            print("Error: map fails to load! ")
        }
}
    
    //set up the background image
    func setBackground() {
        let bg = SKSpriteNode(imageNamed: "background1.png")
        bg.zPosition = -100
        bgLayer.addChild(bg)

    }
    
    // set up the physics world with gravity
    func setPhysics() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = map!.gravity
        physicsWorld.speed = 1.0
    }
    
    // start the timer to detect current pojectile's motion
    func startTimer () {
        motionTimer.invalidate()
        motionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkIfAtRest), userInfo: nil, repeats: true)
    }
    
    // check if current projectile is at rest and start the delay timer
    func checkIfAtRest () {
        if projectile == nil{
            return
        } else if projectile!.physicsBody == nil {
            return
        }
        
        if nodeSpeed(node: projectile!) < 3
            || projectile.position.x > self.frame.maxX || projectile.position.x < self.frame.minX {
            if (delayTimer.isValid == false) {
                startDelay()
            }
        } else { // still in motion
            delayTimer.invalidate()
        }
    }
    
    // several seconds after projectile is at rest, stop current projectile
    func startDelay () {
        delayTimer.invalidate()
        delayTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(nextProjectile), userInfo: nil, repeats: false)
    }
    
    // destroy old projectile and create a new one if available
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
    
    // set up slingshot pieces
    func setupSlingshot() {
        let slingshot0 = SKSpriteNode(imageNamed: "shot0.png")
        let slingshot1 = SKSpriteNode(imageNamed: "shot1.png")
        
        shotPosition = CGPoint(x: self.frame.origin.x+slingshot0.frame.width*2.333,
                                         y: self.frame.origin.y+slingshot0.frame.height*0.505)
        projectileRestPosition = CGPoint(x: shotPosition.x+20, y: shotPosition.y+60)
        
        slingshot1.position = shotPosition
        slingshot1.zPosition = 10
        mainLayer.addChild(slingshot1)
        
        slingshot0.position = shotPosition
        slingshot0.zPosition = -10
        mainLayer.addChild(slingshot0)
    }
    
    // create given projectile ready to throw
    func setupProjectile (object: Throwable) -> Int {
        checkGoal()
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
            throwableNodes.append(projectile)
            mainLayer.addChild(projectile)
            
            dicFindThrowable.updateValue(object, forKey: projectile)
        } else {
            return 0
        }
        return 1
    }
    
    // load given level
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
                node.physicsBody!.density = 0.33
                node.physicsBody!.categoryBitMask = GameScene.woodCategory
                node.physicsBody!.contactTestBitMask = GameScene.throwableCategory
                node.physicsBody!.affectedByGravity = target.type!.affectByGravity
                
                targetNodes.append(node)
                mainLayer.addChild(node)
            }
        }
        
        return count
        
    }
    
    func removeCurrentMap() {
        motionTimer.invalidate()
        delayTimer.invalidate()
        
        for node in throwableNodes {
            node.removeFromParent()
        }
        
        for node in targetNodes {
            node.removeFromParent()
        }
    }
    
    // check if player has satisfied requirement to pass current level
    func checkGoal() {
        for node in targetNodes {
            let t = dicFindTarget[node]
            if t != nil {
                if (t!.type!.mustDestroy && node.parent != nil) {
                    return
                }
            }
        }
        isPassed()
    }
    
    // called when destroy every target in a level
    func isPassed () {
        removeCurrentMap()
        let pass = SKSpriteNode(imageNamed: "passed.png")
        hintLayer.addChild(pass)
        currentLevel += 1
        gameStarted = false
        print("Is passed")
    }
    
    // called when fail to destroy all targets when run out of throwables
    func isFailed () {
        removeCurrentMap()
        let fail = SKSpriteNode(imageNamed: "failed.png")
        hintLayer.addChild(fail)
        gameStarted = false
        print("Is failed")
    }
    
    // deal with deteched collisions between projectile and targets
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
            let damage = Double(nodeSpeed(node: node)) * t.hitImpact + 1.0
            target.decreaseDamageValue(amount: damage)
            node.alpha = CGFloat(target.damageValue)/CGFloat(target.maxDamageValue)
            if target.damageValue == 0 {
                node.removeFromParent()
                checkGoal()
            }
        }
        
    }
    
    // return distance of two given points
    func fingerDistanceFromProjectileRestPosition(_ projectileRestPosition: CGPoint, fingerPosition: CGPoint) -> CGFloat {
        return sqrt(pow(projectileRestPosition.x - fingerPosition.x,2) + pow(projectileRestPosition.y - fingerPosition.y,2))
    }
    
    func nodeSpeed(node: SKNode) -> Double {
        if node.physicsBody == nil{
            return 0
        }
        return sqrt(Double(pow(node.physicsBody!.velocity.dx, 2)) + Double(pow(node.physicsBody!.velocity.dy, 2)))
    }
    
    //return projectile's expected position when dragged
    func projectilePositionForFingerPosition(_ fingerPosition: CGPoint, projectileRestPosition:CGPoint, circleRadius rLimit:CGFloat) -> CGPoint {
        let φ = atan2(fingerPosition.x - projectileRestPosition.x, fingerPosition.y - projectileRestPosition.y)
        let cX = sin(φ) * rLimit
        let cY = cos(φ) * rLimit
        return CGPoint(x: cX + projectileRestPosition.x, y: cY + projectileRestPosition.y)
    }
    
    // start dragging projectile
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if projectile == nil{
            return
        }
        
        if !gameStarted {
            startGame()
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
    
    // drag projectile when at the slingshot
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
    
    // throw out projectile
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
                projectile.physicsBody!.density = 1
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
