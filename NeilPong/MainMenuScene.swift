//
//  MainMenuScene.swift
//  NeilPong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//



import Foundation
import SpriteKit
import AVFoundation

var currentGameType = gameType.easy

class MainMenuScene:SKScene {
    
    let pixelFont = "LLPixel"
    let mainTitle = SKLabelNode(fontNamed: "LLPixel")
    let creditName = SKLabelNode(fontNamed: "LLPixel")
    let gameSettingEasyLabel = SKLabelNode(fontNamed: "LLPixel")
    let gameSettingMediumLabel = SKLabelNode(fontNamed: "LLPixel")
    let gameSettingHardLabel = SKLabelNode(fontNamed: "LLPixel")
    let twoPlayerLabel = SKLabelNode(fontNamed: "LLPixel")
    let musicLabel = SKLabelNode(fontNamed: "LLPixel")
    
    
    override func didMove(to view: SKView) {
        
        
        //set up scene
        self.backgroundColor = SKColor.black
        
        
        mainTitle.text = "Pong !"
        mainTitle.fontSize = 100
        mainTitle.fontColor = SKColor.white
        mainTitle.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.80)
        mainTitle.zPosition = 1
        self.addChild(mainTitle)
        
        creditName.text = "code by Neil Houselander"
        creditName.fontSize = 30
        creditName.fontColor = SKColor.gray
        creditName.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.75)
        creditName.zPosition = 1
        self.addChild(creditName)
        
        
        gameSettingEasyLabel.text = "Easy"
        gameSettingEasyLabel.fontSize = 75
        gameSettingEasyLabel.fontColor = SKColor.white
        gameSettingEasyLabel.position = CGPoint(x: self.size.width + self.size.width, y: self.size.height * 0.60)
        gameSettingEasyLabel.zPosition = 1
        gameSettingEasyLabel.name = "easy"
        self.addChild(gameSettingEasyLabel)
        
        
        gameSettingMediumLabel.text = "Medium"
        gameSettingMediumLabel.fontSize = 75
        gameSettingMediumLabel.fontColor = SKColor.white
        gameSettingMediumLabel.position = CGPoint(x: -self.size.width - self.size.width, y: self.size.height * 0.50)
        gameSettingMediumLabel.zPosition = 1
        gameSettingMediumLabel.name = "medium"
        self.addChild(gameSettingMediumLabel)
        
        
        gameSettingHardLabel.text = "Hard"
        gameSettingHardLabel.fontSize = 75
        gameSettingHardLabel.fontColor = SKColor.white
        gameSettingHardLabel.position = CGPoint(x: self.size.width + self.size.width, y: self.size.height * 0.40)
        gameSettingHardLabel.zPosition = 1
        gameSettingHardLabel.name = "hard"
        self.addChild(gameSettingHardLabel)
        
        
        twoPlayerLabel.text = "2 Player"
        twoPlayerLabel.fontSize = 75
        twoPlayerLabel.fontColor = SKColor.white
        twoPlayerLabel.position = CGPoint(x: -self.size.width - self.size.width, y: self.size.height * 0.30)
        twoPlayerLabel.zPosition = 1
        twoPlayerLabel.name = "twoPlayer"
        self.addChild(twoPlayerLabel)
        
        musicLabel.text = "Music: on"
        musicLabel.fontSize = 45
        musicLabel.fontColor = SKColor.white
        musicLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.10)
        musicLabel.zPosition = 1
        musicLabel.name = "music"
        self.addChild(musicLabel)
        
        
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
            
        //if its music DO NOT transition to game, just toggle music so wrap in an IF statemtent
        if nodeTapped.name == "music" {
                if musicLabel.text == "Music: on" {
                    musicLabel.text = "Music: off"
                    
                    backingAudio.stop()
                    
                }
                else {
                    musicLabel.text = "Music: on"
                    
                    backingAudio.play()
                }
            }
            
            //if its not music node then select game type, set gametype & play
        else {
                
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
            
            //transition
            let sceneToMoveTo = GameScene(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let theTransition = SKTransition.fade(withDuration: 1.0)
            self.view?.presentScene(sceneToMoveTo, transition: theTransition)
                
                
            }
        }
    }
}
