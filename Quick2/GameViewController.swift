//
//  GameViewController.swift
//  Quick2
//
//  Created by Pavley, John on 3/3/16.
//  Copyright (c) 2016 Epic Loot. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myScene = MainScene(size:CGSize(width: 2048.0, height: 1536.0))
        
        let myView = self.view as! SKView
        myView.showsFPS = false;
        myView.showsNodeCount = false;
        myView.ignoresSiblingOrder = true;
        
        myScene.scaleMode = .AspectFill
        myView.presentScene(myScene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
