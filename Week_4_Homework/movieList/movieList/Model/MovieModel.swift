//
//  MovieModel.swift
//  movieList
//
//  Created by Fahreddin Gölcük on 22.07.2021.
//

import Foundation

struct MovieModel: Decodable {
    let page: Int
    let results: [MovieItem]
}

// MARK: - Result
struct MovieItem: Decodable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language, original_title, overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String?
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
