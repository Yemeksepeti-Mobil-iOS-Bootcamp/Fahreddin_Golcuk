//
//  Movie.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 27.07.2021.
//

import Foundation

// MARK: - Game Item
struct Game: Codable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let background_image: String
    let rating: Double
    let rating_top: Int
    let ratings: [Ratings]
    let ratings_count: Int
    let reviews_text_count: Int
    let added: Int?
    let added_by_status: AddedStatus?
    let metacritic, playtime, suggestions_count: Int?
    let updated: String?
    let esrb_rating: EsrbRatings?
    let platforms: [Platform]?
}

// MARK: - Ratings
struct Ratings: Codable {
    let id: Int?
    let title: String?
    let count: Int
    let percent: Double
}

// MARK: - ESRB Ratings
struct EsrbRatings: Codable {
    let id: Int
    let slug: String
    let name: String
}

// MARK: - Platform
struct Platform: Codable {
    let platform: EsrbRatings
    let released_at: String?
}

// MARK: - AddedByStatus
struct AddedStatus: Codable {
    let yet, owned, beaten, toplay, dropped, playing: Int
}


