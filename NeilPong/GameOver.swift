//
//  GameOver.swift
//  NeilPong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import Foundation
import SpriteKit

class GameOver: SKScene {
    
    let gameOverSound = SKAction.playSoundFileNamed("game_over_sound.wav", waitForCompletion: false)
    
    let restartLabel = SKLabelNode(fontNamed: "LLPixel")
    
    override func didMove(to view: SKView) {
        
        //who is the winner logic
        var winner = ""
        if gameScore[0] > gameScore [1] {
            
            winner = "Player 1"
        }
            
        else if gameScore[0] < gameScore[1] && currentGameType == gameType.twoPlayer {
            
            winner = "Player 2"
            
        }
        else {
            
            winner = "Computer"
            
        }
        
        //set up scene
        self.backgroundColor = SKColor.black
        
        let gameOverTitle = SKLabelNode(fontNamed: "LLPixel")
        gameOverTitle.text = "Game Over"
        gameOverTitle.fontSize = 110
        gameOverTitle.fontColor = SKColor.white
        gameOverTitle.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.80)
        gameOverTitle.zPosition = 1
        gameOverTitle.alpha = 0
        self.addChild(gameOverTitle)
        
        let mainWinnerLabel = SKLabelNode(fontNamed: "LLPixel")
        mainWinnerLabel.text = "Winner: "
        mainWinnerLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.6)
        mainWinnerLabel.fontSize = 80
        mainWinnerLabel.fontColor = SKColor.white
        mainWinnerLabel.alpha = 0
        mainWinnerLabel.zPosition = 1
        self.addChild(mainWinnerLabel)
        
        let winnerLabel = SKLabelNode(fontNamed: "LLPixel")
        winnerLabel.alpha = 0
        winnerLabel.text = "\(winner)"
        winnerLabel.fontSize = 70
        winnerLabel.fontColor = SKColor.white
        winnerLabel.position = CGPoint(x: self.size.width * 0.50, y: self.size.height*0.5)
        winnerLabel.zPosition = 1
        self.addChild(winnerLabel)
        
        
        restartLabel.text = "Restart"
        restartLabel.fontColor = SKColor.white
        restartLabel.fontSize = 80
        restartLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.30)
        restartLabel.zPosition = 1
        restartLabel.alpha = 0
        self.addChild(restartLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        
        //how long before waiting to appear
        let gameOverWait = SKAction.wait(forDuration: 1.0)
        let winnerTitleFadeWait = SKAction.wait(forDuration: 2.5)
        let winnerWaitAction = SKAction.wait(forDuration: 5.0)
        let restartWaitAction = SKAction.wait(forDuration: 6.5)
        
        //sequences
        let gameOverSequence = SKAction.sequence([gameOverWait,gameOverSound, fadeInAction])
        let winnerTitleFadeInSequence = SKAction.sequence([winnerTitleFadeWait, fadeInAction])
        let fadeInSequence = SKAction.sequence([winnerWaitAction, fadeInAction])
        let otherFadeInSequence = SKAction.sequence([restartWaitAction, fadeInAction])

        //run
        gameOverTitle.run(gameOverSequence)
        mainWinnerLabel.run(winnerTitleFadeInSequence)
        winnerLabel.run(fadeInSequence)
        restartLabel.run(otherFadeInSequence)
        

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if restartLabel.contains(pointOfTouch) {
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let aTransition = SKTransition.fade(withDuration: 0.5)
                self.view?.presentScene(sceneToMoveTo, transition: aTransition)
            }
            
        }

    }

}
