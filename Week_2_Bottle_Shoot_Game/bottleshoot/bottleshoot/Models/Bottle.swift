//
//  Bottle.swift
//  bottleshoot
//
//  Created by Fahreddin Gölcük on 30.06.2021.
//
import GameplayKit
import SpriteKit

class Bottle: SKSpriteNode {
    var location: Double = Double.random(in: 1...1500) //0-1500m between (m)
    var delta: Double = 100
    var state: Bool = true
        
    func isShooted(range: Double) -> Bool {
        let min = self.location - self.delta
        let max = self.location + self.delta
        if(min <= range && max >= range) {
            self.state = false
        }
        return min <= range && max >= range
    }
}
