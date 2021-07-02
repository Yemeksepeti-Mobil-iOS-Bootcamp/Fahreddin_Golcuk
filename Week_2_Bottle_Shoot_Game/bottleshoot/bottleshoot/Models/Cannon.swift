//
//  Cannon.swift
//  bottleshoot
//
//  Created by Fahreddin Gölcük on 30.06.2021.
//
import GameplayKit
import SpriteKit
let GRAVITY: Double = 10

class Cannon: SKSpriteNode {
    var angle: Double = 0.0 //0-90 between degree (teta)
    var throwSpeed: Double = 0.0 //0-100 between (m/s)
    var range: Double = 0.0
    
    func calculateRange() {
        self.range = abs(throwSpeed * throwSpeed * sin(2 * angle) / GRAVITY)
        print("range \(self.range )")
    }
}
