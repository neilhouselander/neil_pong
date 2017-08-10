//
//  MainMenuScene.swift
//  NeilPong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

//EXTRA TO DO - animate meu items onto scene 1 layer at a time

import Foundation
import SpriteKit

enum gameType {
    case easy
    case medium
    case hard
    case twoPlayer
}



class MainMenuScene:SKScene {
    
    let pixelFont = "LLPixel"
    let mainTitle = SKLabelNode(fontNamed: "LLPixel")
    let gameSettingEasyLabel = SKLabelNode(fontNamed: "LLPixel")
    let gameSettingMediumLabel = SKLabelNode(fontNamed: "LLPixel")
    let gameSettingHardLabel = SKLabelNode(fontNamed: "LLPixel")
    let twoPlayerLabel = SKLabelNode(fontNamed: "LLPixel")
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor.black
        
        
        mainTitle.text = "Neil Pong !"
        mainTitle.fontSize = 140
        mainTitle.fontColor = SKColor.white
        mainTitle.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.80)
        mainTitle.zPosition = 1
        self.addChild(mainTitle)
        
        
        gameSettingEasyLabel.text = "Easy"
        gameSettingEasyLabel.fontSize = 100
        gameSettingEasyLabel.fontColor = SKColor.white
        gameSettingEasyLabel.position = CGPoint(x: self.size.width + self.size.width, y: self.size.height * 0.60)
        gameSettingEasyLabel.zPosition = 1
        gameSettingEasyLabel.name = "easy"
        self.addChild(gameSettingEasyLabel)
        
        
        gameSettingMediumLabel.text = "Medium"
        gameSettingMediumLabel.fontSize = 100
        gameSettingMediumLabel.fontColor = SKColor.white
        gameSettingMediumLabel.position = CGPoint(x: -self.size.width - self.size.width, y: self.size.height * 0.50)
        gameSettingMediumLabel.zPosition = 1
        gameSettingMediumLabel.name = "medium"
        self.addChild(gameSettingMediumLabel)
        
        
        gameSettingHardLabel.text = "Hard"
        gameSettingHardLabel.fontSize = 100
        gameSettingHardLabel.fontColor = SKColor.white
        gameSettingHardLabel.position = CGPoint(x: self.size.width + self.size.width, y: self.size.height * 0.40)
        gameSettingHardLabel.zPosition = 1
        gameSettingHardLabel.name = "hard"
        self.addChild(gameSettingHardLabel)
        
        
        twoPlayerLabel.text = "2 Player"
        twoPlayerLabel.fontSize = 100
        twoPlayerLabel.fontColor = SKColor.white
        twoPlayerLabel.position = CGPoint(x: -self.size.width - self.size.width, y: self.size.height * 0.30)
        twoPlayerLabel.zPosition = 1
        twoPlayerLabel.name = "twoPlayer"
        self.addChild(twoPlayerLabel)
        
        animateOn()
        
    }
    
    func animateOn() {
        
        let easyAnimate = SKAction.moveTo(x: self.size.width * 0.5, duration: 1.5)
        gameSettingEasyLabel.run(easyAnimate)
        gameSettingMediumLabel.run(easyAnimate)
        gameSettingHardLabel.run(easyAnimate)
        twoPlayerLabel.run(easyAnimate)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let pointOfTouch = touch.location(in: self)
            let nodeTapped = atPoint(pointOfTouch)
            
            if nodeTapped.name == "easy" {
                currentGameType = gameType.easy
                print("easy")
                
            }
            
            if nodeTapped.name == "medium" {
                currentGameType = gameType.medium
                print("medium")
                
            }
            
            if nodeTapped.name == "hard" {
                currentGameType = gameType.hard
                print("hard")
                
            }
            
            if nodeTapped.name == "twoPlayer" {
                currentGameType = gameType.twoPlayer
                print("twoplayer")
                
            }
            
            let sceneToMoveTo = GameOver(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let theTransition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(sceneToMoveTo, transition: theTransition)
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
