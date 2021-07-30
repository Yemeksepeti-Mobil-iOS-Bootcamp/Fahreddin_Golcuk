//
//  ViewController.swift
//  movieList
//
//  Created by Fahreddin Gölcük on 22.07.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //MARK: -General variable
    fileprivate var layoutPattern: Bool = false
    fileprivate var PAGE: Int = 1
    //MARK: -MVVM - ViewModel
    let movieViewModel = MovieViewModel()
    
    //MARK: -Controller components
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 40))
    var collectionView: UICollectionView!
    
    //MARK: -Navigation bar buttons
    var gridButton: UIBarButtonItem!
    var favoriteButton: UIBarButtonItem!
    
    //MARK: -Fetch data wait variable.
    var isWaiting: Bool = false
    
    //MARK: -Favorite movies show state
    var isOpenFavorite: Bool = false {
        didSet{
            if(isOpenFavorite){
                favoriteButton.image = UIImage(systemName: "star.fill")
            }else {
                favoriteButton.image = UIImage(systemName: "star")
            }
        }
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Navigation Bar settings
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Movies")
        gridButton = UIBarButtonItem(image: UIImage(systemName: "tablecells"), style: .done, target: self, action: #selector(changeDesign))
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(favoriteMovieList))
        navItem.rightBarButtonItems = [gridButton, favoriteButton]
        navBar.setItems([navItem], animated: false)
        view.addSubview(navBar)
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: view.frame.size.width, height: 44))
        
        //MARK: -SEARCH BAR
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = "Search movie"
        searchBar.tintColor = UIColor(red:0.73, green:0.76, blue:0.78, alpha:1.0)
        self.view.addSubview(searchBar)
        searchBar.anchor(top: navBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        //MARK: -COLLECTIONVIEW SETTINGS
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.anchor(top: searchBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    //MARK: -Navigation top bar hide configuration
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: -GRID OR TABLE VIEW PASS OF LIST
    @objc func changeDesign(){
        let padding: CGFloat = 8
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: view.frame.width * ( layoutPattern ? 0.4 : 0.9), height: view.frame.height / 3)
        collectionView.startInteractiveTransition(to: layout, completion: nil)
        gridButton.image = UIImage(systemName: layoutPattern ? "tablecells" : "square.grid.3x2")
        layoutPattern = !layoutPattern
        collectionView.finishInteractiveTransition()
        collectionView.reloadData()
    }
    
    @objc func favoriteMovieList(){
        movieViewModel.favoriteList()
        if(isOpenFavorite){
            movieViewModel.filterList(searchText: "", isEmpty: true)
            self.isOpenFavorite = false
        }else {
            self.isOpenFavorite = true
        }
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
        
    //MARK: -Collection View Cell Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.filteredMovieList?.count ?? 0
    }
    
    //MARK: -CollectionView introduce to custom view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
        cell?.configure(with: movieViewModel.filteredMovieList?[indexPath.row])
        cell?.contentView.isUserInteractionEnabled = true
        return cell!
    }
    
    //MARK: -CollectionView trigger when pressed item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.movieItem = movieViewModel.filteredMovieList?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -CollectionView trigger when came end of list.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movieViewModel.filteredMovieList!.count - 2 && !isWaiting && !isOpenFavorite {
            self.isWaiting = true
            PAGE += 1
            self.doPaging()
        }
    }
    
    //MARK: -Get new movie list
    private func doPaging() {
        self.movieViewModel.getMovies(page: PAGE)
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async {
                self.isWaiting = false
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: -Update list on view model via search bar
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var isSearchBarEmpty: Bool {
            return searchBar.text?.isEmpty ?? true
        }
        movieViewModel.filterList(searchText: searchBar.text!,isEmpty: isSearchBarEmpty)
        collectionView.reloadData()
    }
}
