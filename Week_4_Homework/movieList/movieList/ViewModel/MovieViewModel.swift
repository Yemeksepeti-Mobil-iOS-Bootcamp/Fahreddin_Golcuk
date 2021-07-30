//
//  MovieViewModel.swift
//  movieList
//
//  Created by Fahreddin Gölcük on 25.07.2021.
//
import UIKit
import Foundation
import CoreData

class MovieViewModel {
    var movieList: [MovieItem]?
    var filteredMovieList: [MovieItem]?
    
    init() {
        getMovies(page: 1)
    }
    
    func getMovies(page: Int) {
        let api = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=\(page)")
        URLSession.shared.dataTask(with: api!) {
            data, response, error in
            if error != nil {
                return
            }
            do {
                let result = try JSONDecoder().decode(MovieModel.self, from: data!)
                if (page > 1) {
                    self.movieList?.append(contentsOf: result.results)
                    self.filteredMovieList?.append(contentsOf: result.results)
                }else {
                    self.movieList = result.results
                    self.filteredMovieList = result.results
                }
            } catch {
                print(String(describing: error))
            }
        }.resume()        
    }
    
    func filterList(searchText: String, isEmpty: Bool) {
        if(isEmpty){
            filteredMovieList = movieList
        } else{
            filteredMovieList = movieList?.filter({ (movie: MovieItem) -> Bool in
                return movie.title.lowercased().contains(searchText.lowercased())
            })
        }
    }
    
    func favoriteList() {
        filteredMovieList?.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "id") as? Int else { return }
                    if((movieList?.contains(where: {$0.id == name })) != nil){
                        if let filtered = movieList?.filter({ movie in
                            return movie.id == name
                        }).first {
                            filteredMovieList?.append(filtered)
                        }
                    }
                }
            }
        } catch {
            print("Error")
        }
    }
}
