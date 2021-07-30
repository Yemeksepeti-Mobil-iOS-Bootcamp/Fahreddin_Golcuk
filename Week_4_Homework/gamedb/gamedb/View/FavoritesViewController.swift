//
//  FavoritesViewController.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 27.07.2021.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    var favoriteGameList: [Game]?
    
    var gameList: [Game]? {
        didSet {
            //MARK: -Found favorites game list from entity.
            DispatchQueue.main.async {
                let filteredTmp: [Game] = self.gameList!.filter{ isExist(id: $0.id) }
                self.favoriteGameList = filteredTmp
                self.collectionView.reloadData()
            }
        }
    }
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.topViewController?.title = "Favorites"
        
        //MARK: -COLLECTIONVIEW SETTINGS
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Favorites"
        tabBarItem.image = UIImage(systemName: "star")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
      
        getGames() { (result) in
            self.gameList = result
        }
    }
}

//MARK: -Collection View Delegate & Data Source
extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: -Collection View Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.9, height: self.view.frame.height / 8)
    }
    
    //MARK: -Collection View Cell Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGameList?.count ?? 0
    }
    
    //MARK: -CollectionView introduce to custom view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell
        cell?.configure(with: favoriteGameList![indexPath.row])
        cell?.contentView.isUserInteractionEnabled = true
        return cell!
    }
    
    //MARK: -CollectionView trigger when pressed item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = GameDetailViewController()
        vc.id = favoriteGameList?[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
