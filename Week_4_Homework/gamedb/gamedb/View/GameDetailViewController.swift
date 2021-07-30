//
//  GameDetailViewController.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 27.07.2021.
//

import UIKit
import CoreData

class GameDetailViewController: UIViewController {
    //MARK: -Game Detail Item
    var id: Int?
    //MARK: -Game Detail private controller items
    fileprivate var gameImage: UIImageView = UIImageView()
    fileprivate var gameHeaderLbl: UILabel = UILabel()
    fileprivate var gameReleaseLbl: UILabel = UILabel()
    fileprivate var gameRateLbl: UILabel = UILabel()
    fileprivate var gameTitleLbl: UILabel = UILabel()
    
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
        view.backgroundColor = .white
        
        //MARK: - IS FAVORITE ?
        getFavoriteState()
        
        //MARK: -Navigation bar favorite button
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(pressFavoriteButton))
        self.navigationItem.rightBarButtonItem = favoriteButton
        
        getGameDetail(id ?? 0) { (result) in
            DispatchQueue.main.async {
                self.title = result.name
                self.gameTitleLbl.text = result.description
                self.gameImage.downloadURL(urlPath: "\(result.background_image)")
                self.gameRateLbl.text = "\(result.rating)/\(result.rating_top)"
                self.gameReleaseLbl.text = result.released
                self.gameHeaderLbl.text = result.name
            }
        }
        
        //MARK: -Game item image component
        gameImage.contentMode = .scaleAspectFit
        view.addSubview(gameImage)
        gameImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: view.frame.width, height: view.frame.height / 3))
        
        //MARK: -Game item header component
        gameHeaderLbl.textColor = .orange
        gameHeaderLbl.font = UIFont.boldSystemFont(ofSize: gameHeaderLbl.font.pointSize)
        view.addSubview(gameHeaderLbl)
        gameHeaderLbl.anchor(top: gameImage.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: view.frame.width, height: 0))
        
        //MARK: -Game item release component
        gameReleaseLbl.textColor = .orange
        gameReleaseLbl.font = UIFont.boldSystemFont(ofSize: gameReleaseLbl.font.pointSize)
        view.addSubview(gameReleaseLbl)
        gameReleaseLbl.anchor(top: gameHeaderLbl.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: view.frame.width, height: 0))
        
        //MARK: -Game item rate component
        gameRateLbl.textColor = .orange
        gameRateLbl.font = UIFont.boldSystemFont(ofSize: gameRateLbl.font.pointSize)
        view.addSubview(gameRateLbl)
        gameRateLbl.anchor(top: gameReleaseLbl.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: view.frame.width, height: 0))
        
        
        //MARK: -Game item title component
        gameTitleLbl.textColor = .black
        gameTitleLbl.numberOfLines = 15
        view.addSubview(gameTitleLbl)
        gameTitleLbl.anchor(top: gameRateLbl.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: view.frame.width, height: 0))
    }
    
    @objc func pressFavoriteButton(){
        if(isFavorite!) { //MARK: -CHECK IS FAVORITE CONTROL
            //MARK: -DELETE FROM CORE DATA
            deleteFromEntity(id: self.id ?? 0)
            self.isFavorite = false
        } else {
            //MARK: -APPEND TO CORE DATA
            self.isFavorite = true
            insertToEntity(id: self.id ?? 0)
        }
    }
    
    private func getFavoriteState() {
        //MARK: - Main thread required.
        DispatchQueue.main.async {
            self.isFavorite = isExist(id: self.id)
        }
    }
    
}
