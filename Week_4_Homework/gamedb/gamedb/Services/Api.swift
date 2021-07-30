//
//  Api.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 28.07.2021.
//

import Foundation

func getGames(completion: @escaping (([Game]) -> Void)) {
    let api = URL(string: "https://api.rawg.io/api/games?key=922a610dedcf4bd982f329eaf335ef8a")
    URLSession.shared.dataTask(with: api!) {
        data, response, error in
        if error != nil {
            return
        }
        do {
            let result = try JSONDecoder().decode(GameResponse.self, from: data!) as GameResponse
            completion(result.results)
            print(result)
        } catch {
            print(String(describing: error))
        }
    }.resume()
}

func getGameDetail(_ gameId: Int, completion: @escaping ((GameDetail) -> Void)) {
    let api = URL(string: "https://api.rawg.io/api/games/\(gameId)?key=922a610dedcf4bd982f329eaf335ef8a")
    URLSession.shared.dataTask(with: api!) {
        data, response, error in
        if error != nil {
            return
        }
        do {
            let result = try JSONDecoder().decode(GameDetail.self, from: data!) as GameDetail
            completion(result)
            print(result)
        } catch {
            print(String(describing: error))
        }
    }.resume()
}
