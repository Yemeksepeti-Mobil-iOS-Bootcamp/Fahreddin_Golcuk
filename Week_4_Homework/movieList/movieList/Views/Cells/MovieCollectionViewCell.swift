//
//  MovieCollectionViewCell.swift
//  movieList
//
//  Created by Fahreddin Gölcük on 25.07.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    private var movieItem: MovieItem?
    fileprivate let title = UILabel()
    fileprivate var movieImage: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        movieImage.contentMode = .scaleAspectFill
        addSubview(movieImage)
        movieImage.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor)
        
        title.backgroundColor = .black
        title.textColor = .white
        addSubview(title)
        title.anchor(top: movieImage.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
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
    
    func configure(with movie: MovieItem?) {
        movieItem = movie
        title.text = movie?.title
        movieImage.downloadURL(urlPath: "https://image.tmdb.org/t/p/w200/\(movie?.backdrop_path ?? "")")
    }
}
