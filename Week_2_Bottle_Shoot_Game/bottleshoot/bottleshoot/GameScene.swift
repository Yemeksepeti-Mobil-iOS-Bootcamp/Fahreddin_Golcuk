//
//  GameScene.swift
//  bottleshoot
//
//  Created by Fahreddin Gölcük on 29.06.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //VALUE OPTIMIZING UPDATE FUNCTION
    private var lastValueSliderAngleCannon: Double = 0.0
    private var lastValueSliderSpeedCannon: Double = 0.0
    private var lastValueSliderBottleLocation: Double = 0.0
    private var lastValuePlayerName: String = ""
    
    
    //BRIDGE UX reference
    var referenceOfGameViewController : GameViewController!
    
    //USES MANAGE GAME
    var gameManager = GameManager()
    var player = Player()
    
    //CUSTOM SKSPRITE PREFABS
    var cannon: Cannon!
    var bottle: Bottle!
    
    //SKNODES
    private var fireButton: SKSpriteNode?
    private var ball: SKSpriteNode?
    private var pointText: SKLabelNode?
    
    override func didMove(to view: SKView) {
        if let _cannon = self.childNode(withName: "//gun") as? Cannon {
            self.cannon = _cannon
        } else {
            print("Cannon was not initialized properly")
        }
        if let _bottle = self.childNode(withName: "//bottle") as? Bottle {
            self.bottle = _bottle
        } else {
            print("Bottle was not initialized properly")
        }
        self.fireButton = self.childNode(withName: "//fireButton") as? SKSpriteNode
        self.ball = self.childNode(withName: "//gun")?.childNode(withName: "//ball") as? SKSpriteNode
        self.pointText = self.childNode(withName: "//point") as? SKLabelNode
        ball?.physicsBody?.affectedByGravity = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesArray = nodes(at: location)
            
            for node in nodesArray {
                if node.name == "fireButton" { //trigger when i push firebutton in screen
                    pointText?.text = String(player.point)
                    ball?.physicsBody?.affectedByGravity = true
                    if(ball?.physicsBody?.affectedByGravity == true){
                        self.ball?.physicsBody?.applyImpulse((CGVector(dx: cannon.range, dy: 400)))
                        gameManager.shoot(bottle: bottle, player: player, cannon: cannon)
                        pointText?.text = String(player.point)
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if !bottle.state { //if bottle shooted, bottle rotation vertical
            bottle?.zRotation = CGFloat(90)
        }
        
        //SLIDER ANGLE
        if(lastValueSliderAngleCannon != Double(referenceOfGameViewController.angleSlider.value)){
            lastValueSliderAngleCannon = Double(referenceOfGameViewController.angleSlider.value)
            cannon?.zRotation = CGFloat(Double(referenceOfGameViewController.angleSlider.value / 60))
            cannon?.angle = Double(referenceOfGameViewController.angleSlider.value)
        }
        
        //SLIDER SPEED
        if(lastValueSliderSpeedCannon != Double(referenceOfGameViewController.speedSlider.value)){
            lastValueSliderSpeedCannon = Double(referenceOfGameViewController.speedSlider.value)
            cannon?.throwSpeed = Double(referenceOfGameViewController.speedSlider.value)
            cannon?.calculateRange()
        }
        
        //PLAYER NAME INPUT
        if(lastValuePlayerName != referenceOfGameViewController.nameLabel.text){
            lastValuePlayerName = referenceOfGameViewController.nameLabel.text!
            player.name = referenceOfGameViewController.nameLabel.text
        }
        
        //SLIDER BOTTLE LOCATION
        if(lastValueSliderBottleLocation != Double(referenceOfGameViewController.bottleLocationSlider.value)){
            lastValueSliderBottleLocation = Double(referenceOfGameViewController.bottleLocationSlider.value)
            bottle.location = Double(referenceOfGameViewController.bottleLocationSlider.value)
            bottle?.position.x = CGFloat(referenceOfGameViewController.bottleLocationSlider.value)
        }
    }
}
