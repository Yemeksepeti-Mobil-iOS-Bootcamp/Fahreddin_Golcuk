//
//  GameManager.swift
//  bottleshoot
//
//  Created by Fahreddin Gölcük on 1.07.2021.
//
import GameplayKit
import SpriteKit
class GameManager {
    func shoot(bottle: Bottle, player: Player, cannon: Cannon){
        cannon.calculateRange()
        let isShooted = bottle.isShooted(range: cannon.range)
        if(isShooted){
            player.point += 1
        }
    }
}

