//
//  MainScene.swift
//  Quick2
//
//  Created by Pavley, John on 3/3/16.
//  Copyright © 2016 Epic Loot. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(size: CGSize) {
        super.init(size:size)
        print("init")
    }
    
    override func didMoveToView(view: SKView) {
        print("didMoveToView")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            print(location)
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
    }

}
