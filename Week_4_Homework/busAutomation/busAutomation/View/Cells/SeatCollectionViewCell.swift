//
//  SeatCollectionViewCell.swift
//  busAutomation
//
//  Created by Fahreddin Gölcük on 30.07.2021.
//

import Foundation
import UIKit

protocol CellChooseDelegate {
    func chooseMan(id: Int)
    func chooseWoman(id: Int)
    func buyError()
}

class SeatCollectionViewCell: UICollectionViewCell {
    static let identifier = "SeatCollectionViewCell"
    
    var delegate: CellChooseDelegate?
    
    fileprivate let seatNumber = UILabel()
    fileprivate var seatImage: UIImageView = UIImageView()
    
    var chooseViewState: Bool = true {
        didSet {
            chooseView.isHidden = chooseViewState
        }
    }
    var chooseView: UIView = UIView()
        
    var seatType: SeatType? {
        didSet {
            switch seatType {
            case .empty:
                seatImage.image = UIImage(named: "empty")
            case .man:
                seatImage.image = UIImage(named: "man")
            case .reserved:
                seatImage.image = UIImage(named: "reserved")
            case .woman:
                seatImage.image = UIImage(named: "woman")
            case .none:
                seatImage.image = UIImage(named: "empty")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        seatNumber.textColor = .white
        addSubview(seatNumber)
        seatImage.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        addSubview(seatImage)
        seatNumber.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        seatNumber.layer.zPosition = 2
        seatImage.layer.zPosition = 1
        
        
        chooseView.backgroundColor = .systemGray
        chooseView.layer.cornerRadius = 16
        chooseView.frame = CGRect(x: -20, y: -10, width: 100, height: 40)
        chooseView.isHidden = true
        chooseView.layer.zPosition = 5
        addSubview(chooseView)
        
        let manButton = UIButton()
        let manImage = UIImageView()
        manImage.image = UIImage(named: "man-choose")
        manButton.addSubview(manImage)
        manImage.anchor(top: manButton.topAnchor, leading: manButton.leadingAnchor, bottom: manButton.bottomAnchor, trailing: manButton.trailingAnchor)
        manButton.addTarget(self, action: #selector(manChoose), for: .touchUpInside)
        chooseView.addSubview(manButton)
        manButton.anchor(top: chooseView.topAnchor, leading: chooseView.leadingAnchor, bottom: chooseView.bottomAnchor, trailing: nil,size: CGSize(width: 50, height: 40))
        
        let womanButton = UIButton()
        let womanImage = UIImageView()
        womanImage.image = UIImage(named: "woman-choose")
        womanButton.addSubview(womanImage)
        womanImage.anchor(top: womanButton.topAnchor, leading: womanButton.leadingAnchor, bottom: womanButton.bottomAnchor, trailing: womanButton.trailingAnchor)
        womanButton.addTarget(self, action: #selector(womanChoose), for: .touchUpInside)
        chooseView.addSubview(womanButton)
        womanButton.anchor(top: chooseView.topAnchor, leading: womanButton.trailingAnchor, bottom: chooseView.bottomAnchor, trailing: chooseView.trailingAnchor,size: CGSize(width: 50, height: 40))
    }
    
    @objc func manChoose(){
        chooseViewState = true
        let canBuy = isCanBuy(id: Int(seatNumber.text ?? "0") ?? 0, gender: 1)
        if canBuy {
            delegate?.chooseMan(id: (Int(seatNumber.text ?? "0") ?? 0) - 1)
            seatType = .reserved
        } else {
            delegate?.buyError()
        }
    }
    
    @objc func womanChoose(){
        chooseViewState = true
        let canBuy = isCanBuy(id: Int(seatNumber.text ?? "0") ?? 0, gender: 0)
        if canBuy {
            delegate?.chooseWoman(id: (Int(seatNumber.text ?? "0") ?? 0) - 1)
            seatType = .reserved
        } else {
            delegate?.buyError()
        }
    }
    
    func isCanBuy(id: Int, gender: Int) -> Bool {
        let opposite = gender == 0 ? 1 : 0
        if id % 2 == 1 {
            if isExist(id: "\(id + 2)-\(opposite)") {
               return false
            }else {
                return true
            }
        }else {
            if isExist(id: "\(id - 2)-\(opposite)") {
               return false
            }else {
                return true
            }
        }
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
    
    func configure(seatNumber: Int, type: SeatType) {
        seatType = type
        self.seatNumber.text = "\(seatNumber + 1)"
    }
    
}

