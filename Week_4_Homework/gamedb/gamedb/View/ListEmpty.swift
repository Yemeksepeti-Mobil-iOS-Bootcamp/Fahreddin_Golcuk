//
//  ListEmpty.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 28.07.2021.
//

import UIKit

class ListEmpty: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let imageView = UIImageView()
        let image = UIImage(named: "notfound")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: frame.width, height: frame.height / 4))
       
        
         let header = UILabel()
         header.textAlignment = .center
         header.text = "Görüntülenecek bir kayıt yok"
         addSubview(header)
         header.anchor(top: imageView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
