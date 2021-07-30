//
//  MovieDetailViewController.swift
//  movieList
//
//  Created by Fahreddin Gölcük on 26.07.2021.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {
    //MARK: -Movie Detail Item
    var movieItem: MovieItem?
    
    //MARK: -Movie Detail private controller items
    fileprivate var movieImage: UIImageView = UIImageView()
    fileprivate var movieHeaderLbl: UILabel = UILabel()
    fileprivate var movieTitleLbl: UILabel = UILabel()
    
    fileprivate var favoriteButton: UIBarButtonItem?
    fileprivate var isFavorite: Bool? = false {
        didSet {
            if(isFavorite!){
                favoriteButton?.image = UIImage(systemName: "star.fill")
            }else {
                favoriteButton?.image = UIImage(systemName: "star")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movieItem?.title
        view.backgroundColor = .white
        
        //MARK: -Navigation bar favorite button
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(pressFavoriteButton))
        self.navigationItem.rightBarButtonItem = favoriteButton
        getFavoriteState()
        
        //MARK: -Movie item image component
        movieImage.downloadURL(urlPath: "https://image.tmdb.org/t/p/w200/\(movieItem?.backdrop_path ?? "")")
        movieImage.contentMode = .scaleAspectFit
        view.addSubview(movieImage)
        movieImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: view.frame.width, height: view.frame.height / 3))
        
        //MARK: -Movie item header title component
        movieHeaderLbl.textColor = .orange
        movieHeaderLbl.font = UIFont.boldSystemFont(ofSize: movieHeaderLbl.font.pointSize)
        movieHeaderLbl.text = movieItem?.title
        view.addSubview(movieHeaderLbl)
        movieHeaderLbl.anchor(top: movieImage.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: view.frame.width, height: 0))
        
        //MARK: -Movie item description component
        movieTitleLbl.textColor = .black
        movieTitleLbl.text = movieItem?.overview
        movieTitleLbl.numberOfLines = 15
        view.addSubview(movieTitleLbl)
        movieTitleLbl.anchor(top: movieHeaderLbl.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: view.frame.width, height: 0))
    }
    
    @objc func pressFavoriteButton(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let movie = NSEntityDescription.insertNewObject(forEntityName: "Movies", into: context)
        if(isFavorite!) { //MARK: -CHECK IS FAVORITE CONTROL
            //MARK: -DELETE FROM CORE DATA
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Movies")
            fetchRequest.predicate = NSPredicate(format: "id = %@", "\(movieItem?.id ?? 0)")
            do {
                let results = try context.fetch(fetchRequest)
                let resultData = results as! [NSManagedObject]
                for object in resultData {
                    context.delete(object)
                }
                do {
                    try context.save()
                    print("TABLEVIEW-EDIT: saved!")
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                } catch {
                    // add general error handle here
                }
                try context.save()
            } catch {
                print("error")
            }
            self.isFavorite = false
        } else {
            //MARK: -APPEND TO CORE DATA
            movie.setValue(movieItem?.id, forKey: "id")
            do {
                self.isFavorite = true
                try context.save()
            } catch  {
                print("Not saved.")
            }
        }
    }
        
    private func getFavoriteState() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "id") as? Int else { return }
                    if(name == movieItem?.id){
                        self.isFavorite = true
                    }
                }
            }
        } catch {
            print("Error")
        }
    }
    
    
}

