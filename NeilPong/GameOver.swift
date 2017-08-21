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
        gameOverTitle.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.65)
        gameOverTitle.zPosition = 1
        self.addChild(gameOverTitle)
        
        let mainWinnerLabel = SKLabelNode(fontNamed: "LLPixel")
        mainWinnerLabel.text = "Winner: "
        mainWinnerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        mainWinnerLabel.fontSize = 80
        mainWinnerLabel.fontColor = SKColor.white
        mainWinnerLabel.position = CGPoint(x: 20, y: self.size.height*0.50)
        mainWinnerLabel.zPosition = 1
        self.addChild(mainWinnerLabel)
        
        let winnerLabel = SKLabelNode(fontNamed: "LLPixel")
        winnerLabel.alpha = 0
        winnerLabel.text = "\(winner)"
        winnerLabel.fontSize = 70
        winnerLabel.fontColor = SKColor.white
        winnerLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height*0.5)
        winnerLabel.zPosition = 1
        self.addChild(winnerLabel)
        
        
        restartLabel.text = "Restart"
        restartLabel.fontColor = SKColor.white
        restartLabel.fontSize = 80
        restartLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.30)
        restartLabel.zPosition = 1
        self.addChild(restartLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        let waitAction = SKAction.wait(forDuration: 2.0)
        let fadeInSequence = SKAction.sequence([waitAction, fadeInAction])
        winnerLabel.run(fadeInSequence)
        

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
