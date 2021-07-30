//
//  GameDetail.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 27.07.2021.
//

import Foundation

// MARK: - GameDetail Item
struct GameDetail: Codable {
    let id: Int
    let slug: String
    let name: String
    let description: String
    let rating: Double
    let rating_top: Int
    let background_image: String
    let released: String
}
