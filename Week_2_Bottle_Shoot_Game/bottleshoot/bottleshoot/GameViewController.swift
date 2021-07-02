//
//  GameViewController.swift
//  bottleshoot
//
//  Created by Fahreddin Gölcük on 29.06.2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottleLocationLabel: UILabel!
    @IBOutlet weak var bottleLocationSlider: UISlider!
    
    var currentGame: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                currentGame = scene as? GameScene
                currentGame?.referenceOfGameViewController = self
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func angleChanged(_ sender: Any) {
        angleLabel.text = "\(angleSlider.value)"
    }
    @IBAction func speedChanged(_ sender: Any) {
        speedLabel.text = "\(speedSlider.value)"
    }
    @IBAction func bottleLocationChanged(_ sender: Any) {
        bottleLocationLabel.text = "\(bottleLocationSlider.value)"
    }
    
    @IBAction func changedNameField(_ sender: Any) {
        let name = nameField.text
        nameLabel.text = name
    }
}
