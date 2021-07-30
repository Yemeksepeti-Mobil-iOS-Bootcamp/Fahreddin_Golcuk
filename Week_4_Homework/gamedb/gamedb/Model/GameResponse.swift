//
//  MovieResponse.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 27.07.2021.
//

struct GameResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Game]
}
