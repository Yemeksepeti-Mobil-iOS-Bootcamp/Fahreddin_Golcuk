//
//  GameCollectionViewCell.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 27.07.2021.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    static let identifier = "GameCollectionViewCell"
        
    fileprivate let title = UILabel()
    fileprivate let rating = UILabel()
    fileprivate let release = UILabel()
    fileprivate let gameImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        layer.cornerRadius = 16
        addSubview(gameImage)
        addSubview(title)
        addSubview(release)
        addSubview(rating)
        
        gameImage.contentMode = .scaleToFill
        gameImage.clipsToBounds = true
        gameImage.layer.cornerRadius = 16
        gameImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        gameImage.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
        
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 17.0)
        title.textAlignment = .center
        title.anchor(top: safeAreaLayoutGuide.topAnchor, leading: gameImage.trailingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: frame.width * 0.7, height: frame.height / 2))
        
        rating.textColor = .darkGray
        rating.textAlignment = .center
        rating.anchor(top: title.bottomAnchor, leading: gameImage.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: release.leadingAnchor,size: CGSize(width: frame.width * 0.35, height: frame.height))
        
        release.textColor = .darkGray
        release.textAlignment = .center
        release.anchor(top: title.bottomAnchor, leading: rating.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: frame.width * 0.35, height: frame.height))
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with game: Game) {
        title.text = game.name
        rating.text = "\(game.rating)/5"
        release.text = game.released
        gameImage.downloadURL(urlPath: game.background_image)
    }
    
}
