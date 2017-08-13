//
//  GameScene.swift
//  NeilPong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import SpriteKit
import GameplayKit

var gameScore = [Int]()

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
        
        //set up bat size dependant on difficulty
        
        switch currentGameType {
            
        case .easy: playerBat.size = CGSize(width: 200, height: 30)
        case .medium: playerBat.size = CGSize(width: 150, height: 30)
        case .hard: playerBat.size = CGSize(width: 100, height: 30)
        default: playerBat.size = CGSize(width: 200, height: 30)
            
        }
        
        //add the assets
        ball.setScale(0.5)
        ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        ball.zPosition = 1
        ball.name = "ball"
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
        playerBat.name = "playerBat"
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
        enemyBat.name = "enemyBat"
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

    }
    
    func generateRandomDirection() {
        
        var difficultyMultiplier:Int = 0
        
        switch currentGameType {
        case .easy: difficultyMultiplier = 10
        case .medium: difficultyMultiplier = 20
        case .hard: difficultyMultiplier = 30
        case .twoPlayer: difficultyMultiplier = 10
       
            
        }
        
        var randomDx:Int = 0
        var randomDy:Int = 0
        
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
        
        ball.physicsBody?.applyImpulse(CGVector(dx: randomDx, dy: randomDy))

    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == playerBat {
            
            gameScore[0] += 1
            
        }
            
        else if playerWhoWon == enemyBat {
            
            gameScore[1] += 1
            
        }
        
   
        //update scores on screen
        playerTwoScoreLabel.text = "\(gameScore[1])"
        playerOneScoreLabel.text = "\(gameScore[0])"
        
        //check for game over if not get ball moving
                if gameScore[0] > 10  {
        
                    gameOver()
                }
        
                else if gameScore[1] > 10 {
        
                    gameOver()
                }
        
                else {
        
                    generateRandomDirection()

                }
        
    }


    
    func gameOver(){
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "ball", using: {
            ball, stop in
            ball.removeAllActions()
        })
        
        self.enumerateChildNodes(withName: "playerBat", using: {
            player, stop in
            player.removeAllActions()
        })
        
        self.enumerateChildNodes(withName: "enemyBat", using: {
            enemy, stop in
            enemy.removeAllActions()
        })
        
        //move to gameover scene
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 2)
        let changeSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSequence)
        
    }
    
    func changeScene(){
        
        let sceneToMoveTo = GameOver(size:self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let theTransition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(sceneToMoveTo, transition: theTransition)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let playerMoveAction = SKAction.moveTo(x: location.x, duration: 0.01)
            
            if currentGameType == gameType.twoPlayer {
                
                if location.y > 0 {
                    
                    enemyBat.run(playerMoveAction)
                }
                
                if location.y < 0 {
                    
                    playerBat.run(playerMoveAction)
                }
            }
                
            else {
                playerBat.run(playerMoveAction)
            }
            
        }
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let playerMoveAction = SKAction.moveTo(x: location.x, duration: 0.01)
            
            if currentGameType == gameType.twoPlayer {
                
                if location.y > 0 {
                    
                    enemyBat.run(playerMoveAction)
                }
                
                if location.y < 0 {
                    
                    playerBat.run(playerMoveAction)
                }
            }
            
            else {
                playerBat.run(playerMoveAction)
            }
            
        }
        

        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        
        
        
        
        
    }
    
    func enemyLogic(){
        
        switch currentGameType {
            
        case .easy:
            let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.8)
            enemyBat.run(enemyMoveAction)
            break
            
        case .medium:
            let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.5)
            enemyBat.run(enemyMoveAction)
            break
            
        case .hard:
            let enemyMoveAction = SKAction.moveTo(x: ball.position.x, duration: 0.3)
            enemyBat.run(enemyMoveAction)
            break
            
        case .twoPlayer:
            break
            
        }
        
    }

    //use this to control how fast enemy bat is in one player games ALSO to determine wheter point scored
    override func update(_ currentTime: TimeInterval) {
        
        enemyLogic()
        
        
        //score or no score if ball position.y is less than player.y = enemy scores. If ball.y is greater than enemy - i score

        
        if ball.position.y <= playerBat.position.y - 90 {
            
            addScore(playerWhoWon: enemyBat)
            
        }
        else if ball.position.y >= enemyBat.position.y + 90 {
            
            addScore(playerWhoWon: playerBat)
            
        }
        
    }

}
