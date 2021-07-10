//
//  ListEmpty.swift
//  CustomView
//
//  Created by Fahreddin Gölcük on 10.07.2021.
//

import UIKit

class ListEmpty: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let header = UILabel()
        self.backgroundColor = .white
        header.frame = CGRect(x: 0, y: 250, width: frame.width, height: 120)
        header.textAlignment = .center
        header.text = "Görüntülenecek bir kayıt yok"
        addSubview(header)
        
        let imageView = UIImageView()
        let image = UIImage(named: "notfound")
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 200)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
