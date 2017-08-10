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
        
        self.backgroundColor = SKColor.black
        
        let gameOverTitle = SKLabelNode(fontNamed: "LLPixel")
        gameOverTitle.text = "Game Over"
        gameOverTitle.fontSize = 200
        gameOverTitle.fontColor = SKColor.white
        gameOverTitle.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.80)
        gameOverTitle.zPosition = 1
        self.addChild(gameOverTitle)
        
        let winnerLabel = SKLabelNode(fontNamed: "LLPixel")
        winnerLabel.text = "Winner: "
        winnerLabel.fontSize = 100
        winnerLabel.fontColor = SKColor.white
        winnerLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.70)
        winnerLabel.zPosition = 1
        self.addChild(winnerLabel)
        //remember to adjust depending on 2 player game e.g. winner: player 1 or winner: computer
        
        restartLabel.text = "Restart"
        restartLabel.fontColor = SKColor.white
        restartLabel.fontSize = 100
        restartLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.40)
        restartLabel.zPosition = 1
        self.addChild(restartLabel)
        
        
        
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
