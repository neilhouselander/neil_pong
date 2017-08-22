//
//  GameViewController.swift
//  NeilPong
//
//  Created by Neil Houselander on 09/08/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation


//add globals here so works from main menu over into game play & into game over


enum gameType {
    case easy
    case medium
    case hard
    case twoPlayer
}



//end of globals


class GameViewController: UIViewController {
    
    
    var backingAudio = AVAudioPlayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //play backing music
        let filePath = Bundle.main.path(forResource: "backingTrack", ofType: "wav")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)
        
        do {backingAudio = try AVAudioPlayer(contentsOf: audioNSURL as URL) }
        catch {return print("Cannot find backing music")}
        
        backingAudio.numberOfLoops = -1
        backingAudio.play()
        
        //prep scene to load

        
        if let view = self.view as! SKView? {
            
            let scene = MainMenuScene(size: CGSize(width: 750, height: 1334))
            
            scene.scaleMode = SKSceneScaleMode.aspectFit
            
            
            //present scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
