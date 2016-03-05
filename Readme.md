# Quick2 Tutorial: Step One: Game Project Prep

@jpavley
Copyright (c) 2016 Epic Lot
MIT License 

## Introduction

So you wanna develop an iOS game and you're looking for a good place to start. Yeah, me to. Luck for you I did all the work. You just have to sit back and follow a long. But before you do there are some *prerequisites*. Since this not a general lesson on how to be an Apple developer I'm gonna jump to the exciting parts and skip the preliminaries. That means you should already have figured out the following:

- How to get an Apple Developer Account
- How to install Xcode and start it up
- How to work with the Apple Swift 2.x programming language
- How to create a SpiteKit project in Xcode

I respect you and I know you know how to use Google (or DuckDuckGo). Come back when you're ready and we'll get started. It's going to be a blast.

## The Plan

Our shared goal is to start with a blank SpriteKit game project and modify it as little a possible to create a simple game. We're only going to use the basics of SpriteKit: Scenes, Sprites, and Actions. Once you know how to use those things the game world is your oyster. There's a lot more to SpriteKit than these three classes but you have to start small. Sorry, no shortcuts!

You can use this tutorial as a teamplate to create all sorts of single-view games in the spirit of Flappy Bird, Mine Sweeper, and 2028. You know, the classics. After you read this tutorial you don't have to stickaround for the next one.

To accomplish our goal we're going to create a little game I just made up: _Quick2_. Sounds cool! The name is the best part... because it means nothing! In Quick2 the player has to help a colored dot find the shortest path through a maze. Yep, that's right, you're teaching the user how to optimize an algorithm. All the teens are gonna wanna download this baby on to their phablets!

To make our nerdy-yet-awesome game we'll need make a scene, some sprites, some actions, and some game logic. We'll also need artwork and sounds which I will supply in future tutorials. That's right! I'm making this up as I go along.

All set? Excelent! Let's rock-n-roll!

## Prepping the Xcode Project

This tutoral covers the smallest possible starting point of getting your SpritKit game ready for actual work. In this process we delete junk and add in some useful items. When you are done you'll have a generic single-view game template.

- Open Xcode and start a new iOS SpriteKit project and save it somewhere (I have a Dev folder inside my home directory). Make sure you tick on the "universal", "swift", and "git" options.
- Run the game in the similuator or on your phone to make sure it runs. (If it doesn't run go back to your prerequisites research and figure out why.)

SpriteKit games come with boilerplate code and artwork that we have to erase because it isn't very helpful in creating a new game.

- Delete the GameScene.sks file
- Delete the GameScene.swift file
- In the Assets.xcassets file delete the spaceship

Quick2 is going to be a vertical game so we have to convice iOS not to rotate sidewises. (This is harder than it should be.)

- In your project settings in the Deployment Info section set _Landscape Left_ and _Landscape Right_ to unchecked
- In the same place check _Requires Full Screen_
- In your info.plist settings in the _Supported interface orientations (iPad)_ section delete the _Landscape (left home button)_ and _Landscape (right home button)_ items
- In the same place delete the _Portrait (top home button)_ item

This is a good time to commit your changes so that you can revert if you made a booboo. Fromt this point forward commit changes often. I probably won't remember to remind you!

Now we're going to do some real coding! Woot! 

The GameViewController.swift file is the main entry point for your game's entry point. What I mean is the GameViewController object loads first and within it you and explain how to load your game scenes. ViewController are the micromanagers of the client-side software world. Your single-view game will live inside a UIView controlled by the GameViewController. 

- In your GameViewController.swift file find the viewDidLoad() function. Delete all of it's code and rewrite it so it looks like this:

```
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myScene = MainScene(size: CGSize(width: 1536.0, 
        height: 2048.0))
        
        let myView = self.view as! SKView
        myView.showsFPS = false;
        myView.showsNodeCount = false;
        myView.ignoresSiblingOrder = true;
        
        myScene.scaleMode = .AspectFill
        myView.presentScene(myScene)
    }
```
If you learned some basic Swift 2.0 you can easily figure out what this code does. In a nutshell you are creating a SpriteKit scene and asking the UIView associated with GameViewController to display that scene. You are also telling the view not to display any diagnostic info. As you develop your game you might want to turn the diagnostic info back on if the game seems sluggish. You are also telling the view to draw its contents as quickly as possible by ignoring the order in which they have been added to your scene. For a simple single-view game this optimimzation is realtively safe and standard.

To make our lives easy we're going to use a one-sie-fits-all strategy for our game. As off today the magic rectangle of 1536 x 2048 works will for all iOS devices from the tiny iPhone 5s to the giant iPad Pro. iOS will resize the artwork for us if we set scaleMode to ```.AspectFill```. The left and the write sides will show more or less depending on the devices aspect ratio. But we'll just keep the playable game area in the center so that it's always visible.

- Create a new iOS Swift file for your project and name it MainScene.swift
- In your shiny new MainScene.swift file replace its contents with the following code:

```

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
    
    override func touchesBegan(touches: Set<UITouch>, 
    withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            print(location)
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
    }

}

```

Woah! What does all this code do? Run the app and find out! You'll see a featureless black screen. As the game loads in the console you'll see "init" and "didMoveToView" messages. If you touch (or click in the simulator) the screen you'll see the console print the location of your touch.

This my fine friend is a great place to stop. What you have now is a basic single view game template. Once you start to add assets and game logic your game becomes specific. So let's make sure we understand what is going on before we go deep into the madness that is SpriteKit game development.

You'll find you have two different init() functions. The frist one, ```required init?(coder aDecoder: NSCoder)```, is some boilerplate that will (almost) never get called. If it does get called we're not in Kansas anymore and we just give up. Add ths code to every game project but then forget it. 

The ```override init(size: CGSize)``` function is where you will setup your game logic. It is called when your MainScene class is instansiated into memory. The ```size``` param represents the size of the view your game is living within. Its got a height and a width.

The ```override func didMoveToView(view: SKView)``` function is called after initialization by the GameViewController object and is where you'll setup your game objects. By the time this code is called SpriteKit is ready to draw your game on the screen. The ```view``` param is the view object that created your MainScene. You can use it to get all sorts of info and services related to the device your game is living within.

The ```override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)``` function is only called when the user touched the screen. Since iOS support multi-touch you actually get a set of touch objects (in the ```touces``` param). You also potentially get an ```event``` object with info about how the device was touched. Most of the time all us game developer care about is the location of the touch so the function contains a quick & clean way to dig the location point out of each touch object via a for-in loop.

The ```override func update(currentTime: CFTimeInterval)``` function is unused in this example code but it is called once every frame while your game is alive. You this function to implement your game state logic if your game state changes over time. The ```currentTime``` param let's you know when the update has happened. Down the road we'll want to nornalize our reponse to update events so that we update the game state at regular predictable intervals known by professional game developers as "ticks".

## Next Steps

Take a breath. Fool around with the code. Try to create a game from here on your own. Don't worry--you can't break anything with code and you can always roll back your changes with source code control! 

In the next tutorial we'll add some art and algorithms to our mighty single-view game! Stay tuned for more adventure!








