//
//  GameScene.swift
//  NeilPong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //globals for this view
    let playerOneScoreLabel = SKLabelNode(fontNamed: "LLPixel")
    let playerTwoScoreLabel = SKLabelNode(fontNamed: "LLPixel")
    
    let ball = SKSpriteNode(imageNamed: "ball")
    let playerBat = SKSpriteNode(imageNamed: "myBat")
    let enemyBat = SKSpriteNode(imageNamed: "enemyBat")
    
    //sound effects -declare here to avoid lag
    let hitBatSound = SKAction.playSoundFileNamed("pongBlipSound.wav", waitForCompletion: false)
    
    //physics
    struct PhysicsCategories{
        static let None: UInt32 = 0 //0
        static let BatAndBorder: UInt32 = 0b1 //1
        static let Ball: UInt32 = 0b10 //2
        
    }
    
    //gameStates - do i need this? 
    enum gameState{
        case preGame
        case afterGame
        case inGame
    }
    
    //random utilities - for the ball
    func randomInt(min:Int, max:Int) -> Int {
        
        return min + Int(arc4random_uniform(UInt32(max-min + 1)))
        
    }
    
    var randomDx:Int = 0
    var randomDy:Int = 0
    
    //update game area
    let gameArea:CGRect
    
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height/maxAspectRatio
        let margin = (size.width - playableWidth)/2
        gameArea = CGRect(x: margin, y: 0.00, width: playableWidth, height: size.height)
        
        super.init(size: size)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //end of game area set up
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //set up background & physics border
        self.backgroundColor = SKColor.black
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
//        self.physicsBody?.categoryBitMask = PhysicsCategories.BatAndBorder
//        self.physicsBody?.collisionBitMask = PhysicsCategories.Ball
//        self.physicsBody?.contactTestBitMask = PhysicsCategories.Ball
        
        self.physicsBody = border
        
        //add the assets
        ball.setScale(0.5)
        ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        ball.zPosition = 1
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody!.affectedByGravity = false
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.isDynamic = true
        ball.physicsBody!.friction = 0
        ball.physicsBody!.restitution = 1
        ball.physicsBody!.categoryBitMask = PhysicsCategories.Ball
        ball.physicsBody!.collisionBitMask = PhysicsCategories.BatAndBorder
        ball.physicsBody!.contactTestBitMask = PhysicsCategories.BatAndBorder
        self.addChild(ball)
        
        playerBat.setScale(1.0)
        playerBat.position = CGPoint(x: self.size.width/2, y: self.size.height*0.10)
        playerBat.zPosition = 1
        playerBat.physicsBody = SKPhysicsBody(rectangleOf: playerBat.size)
        playerBat.physicsBody?.affectedByGravity = false
        playerBat.physicsBody?.friction = 0
        playerBat.physicsBody?.restitution = 1
        playerBat.physicsBody?.isDynamic = false
        playerBat.physicsBody?.categoryBitMask = PhysicsCategories.BatAndBorder
        playerBat.physicsBody?.collisionBitMask = PhysicsCategories.Ball
        playerBat.physicsBody?.contactTestBitMask = PhysicsCategories.Ball
        self.addChild(playerBat)
        
        enemyBat.setScale(1.0)
        enemyBat.position = CGPoint(x: self.size.width/2, y: self.size.height*0.90)
        enemyBat.zPosition = 1
        enemyBat.physicsBody = SKPhysicsBody(rectangleOf: enemyBat.size)
        enemyBat.physicsBody?.affectedByGravity = false
        enemyBat.physicsBody?.friction = 0
        enemyBat.physicsBody?.restitution = 1
        enemyBat.physicsBody?.isDynamic = false
        enemyBat.physicsBody?.categoryBitMask = PhysicsCategories.BatAndBorder
        enemyBat.physicsBody?.collisionBitMask = PhysicsCategories.Ball
        enemyBat.physicsBody?.contactTestBitMask = PhysicsCategories.Ball
        self.addChild(enemyBat)
        
        playerOneScoreLabel.text = "0"
        playerOneScoreLabel.fontSize = 65
        playerOneScoreLabel.fontColor = SKColor.white
        playerOneScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.40)
        playerOneScoreLabel.zPosition = 100
        self.addChild(playerOneScoreLabel)
        
        playerTwoScoreLabel.text = "4"
        playerTwoScoreLabel.fontSize = 65
        playerTwoScoreLabel.fontColor = SKColor.white
        playerTwoScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.60)
        playerTwoScoreLabel.zRotation = CGFloat(Double.pi)
        playerTwoScoreLabel.zPosition = 100
        self.addChild(playerTwoScoreLabel)
        
        startGame()
        
        
    }
    
    
    
    func startGame(){
        
        gameScore = [0,0]
        playerOneScoreLabel.text = "\(gameScore[0])"
        playerTwoScoreLabel.text = "\(gameScore[1])"
        
        //set initial ball velocity

        generateRandomDirection()
        
        ball.physicsBody?.applyImpulse(CGVector(dx: randomDx, dy: randomDy))
        
 
    }
    
    func generateRandomDirection() {
        
        switch currentGameType {
        case .easy: difficultyMultiplier = 10
        case .medium: difficultyMultiplier = 20
        case .hard: difficultyMultiplier = 30
        case .twoPlayer: difficultyMultiplier = 10
       
            
        }
        
        let randomPlusOrMinus = randomInt(min: 0, max: 3)
        
        switch randomPlusOrMinus {
            
        case 0:
            randomDx = -5 + difficultyMultiplier
            randomDy = -5 + difficultyMultiplier
        case 1:
            randomDx = 5 + difficultyMultiplier
            randomDy = -5 + difficultyMultiplier

        case 2:
            randomDx = 5 + difficultyMultiplier
            randomDy = 5 + difficultyMultiplier

        case 3:
            randomDx = -5 + difficultyMultiplier
            randomDy = 5 + difficultyMultiplier

        default:
            randomDx = 5 + difficultyMultiplier
            randomDy = 5 + difficultyMultiplier
            print("randomdirection function failed - default used")
        }

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }

}
