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
        static let Bat: UInt32 = 0b1 //1
        static let Ball: UInt32 = 0b10 //2
        static let Border:UInt32 = 0b100 //3
    }
    
    //gameStates - do i need this? 
    enum gameState{
        case preGame
        case afterGame
        case inGame
    }
    
    //random utilities - for the ball
    
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
        
        self.physicsBody = border
        
        //add the assets
        ball.setScale(1.0)
        ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        ball.zPosition = 1
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody!.affectedByGravity = false
        ball.physicsBody!.friction = 0
        ball.physicsBody!.restitution = 1
        ball.physicsBody!.categoryBitMask = PhysicsCategories.Ball
        ball.physicsBody!.collisionBitMask = PhysicsCategories.Bat
        ball.physicsBody!.contactTestBitMask = PhysicsCategories.Bat
        self.addChild(ball)
        
        playerBat.setScale(1.0)
        playerBat.position = CGPoint(x: self.size.width/2, y: self.size.height*0.10)
        playerBat.zPosition = 1
        playerBat.physicsBody = SKPhysicsBody(rectangleOf: playerBat.size)
        playerBat.physicsBody?.affectedByGravity = false
        playerBat.physicsBody?.friction = 0
        playerBat.physicsBody?.restitution = 1
        playerBat.physicsBody?.categoryBitMask = PhysicsCategories.Bat
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
        enemyBat.physicsBody?.categoryBitMask = PhysicsCategories.Bat
        enemyBat.physicsBody?.collisionBitMask = PhysicsCategories.Ball
        enemyBat.physicsBody?.contactTestBitMask = PhysicsCategories.Ball
        self.addChild(enemyBat)
        
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }

}
