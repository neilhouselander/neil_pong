//
//  GameScene.swift
//  NeilPong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    //globals for this view
    let playerOneScoreLabel = SKLabelNode(fontNamed: "LLPixel")
    let playerTwoScoreLabel = SKLabelNode(fontNamed: "LLPixel")
    
    //sound effects -declare here to avoid lag
    let hitBatSound = SKAction.playSoundFileNamed("pongBlipSound.wav", waitForCompletion: false)
    
    //physics
    struct PhysicsCategories{
        static let None: UInt32 = 0
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
        
        //set up scene
        self.backgroundColor = SKColor.black
        
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }

}
