//
//  ViewController.swift
//  busAutomation
//
//  Created by Fahreddin Gölcük on 13.07.2021.
//

import UIKit

let SEAT_RATIO: CGFloat = 5.5

class ViewController: UIViewController {
    fileprivate var seatCollectionView: UICollectionView?
    fileprivate var priceLabel: UILabel = UILabel()
    fileprivate var seatsLabel: UILabel = UILabel()
    
    var boughtSeat: [Int:Int] = [:] {
        didSet {
            priceLabel.text = "\(boughtSeat.count * 20) TL"
            var labelSeat: String = ""
            for seat in boughtSeat {
                labelSeat += "| \(seat.key + 1) "
            }
            seatsLabel.text = "SEATS \(labelSeat)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: -Bus wheel component
        let wheel = UIImageView()
        wheel.image = UIImage(named: "wheel")
        view.addSubview(wheel)
        wheel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: 45, height: 45),padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 0))
        
        //MARK: -Bus seperator left component
        let seatSeperatorLeft = UIView()
        seatSeperatorLeft.backgroundColor = .gray
        view.addSubview(seatSeperatorLeft)
        seatSeperatorLeft.anchor(top: wheel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: view.frame.width / 3, height: 4))
        
        //MARK: -Bus seperator right component
        let seatSeperatorRight = UIView()
        seatSeperatorRight.backgroundColor = .gray
        view.addSubview(seatSeperatorRight)
        seatSeperatorRight.anchor(top: wheel.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: view.frame.width / 3, height: 4))
        
        //MARK: -Bus seat collectionview component
        let layout = UICollectionViewFlowLayout()
        seatCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        seatCollectionView?.register(SeatCollectionViewCell.self, forCellWithReuseIdentifier: SeatCollectionViewCell.identifier)
        seatCollectionView?.backgroundColor = UIColor.white
        seatCollectionView?.dataSource = self
        seatCollectionView?.delegate = self
        seatCollectionView?.showsVerticalScrollIndicator = false
        view.addSubview(seatCollectionView ?? UICollectionView())
        seatCollectionView?.anchor(top: seatSeperatorRight.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: CGSize(width: 0, height: view.frame.height * 0.7))
        
        //MARK: -Ticket bottom buy view component
        let continueView = UIView()
        continueView.backgroundColor = .systemOrange
        continueView.layer.cornerRadius = 16
        view.addSubview(continueView)
        continueView.anchor(top: seatCollectionView?.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        //MARK: -Ticket reservated seats label component
        seatsLabel.textAlignment = .center
        continueView.addSubview(seatsLabel)
        seatsLabel.anchor(top: continueView.topAnchor, leading: continueView.leadingAnchor, bottom: nil, trailing: continueView.trailingAnchor, size: CGSize(width: continueView.frame.width * 0.5, height: 50))
        
        //MARK: -Ticket buy button component
        let continueBtn = UIButton(type: .roundedRect)
        continueBtn.backgroundColor = .systemGreen
        continueBtn.layer.cornerRadius = 8
        continueBtn.setTitle("Continue and buy", for: .normal)
        continueBtn.tintColor = .white
        continueBtn.addTarget(self, action: #selector(buyTicketButtonAction), for: .touchUpInside)
        continueView.addSubview(continueBtn)
        continueBtn.anchor(top: seatsLabel.bottomAnchor, leading: continueView.leadingAnchor, bottom: nil, trailing: continueView.trailingAnchor, size: CGSize(width: view.frame.width, height: 50),padding: UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36))
 
        //MARK: -Ticket sum price component
        priceLabel.textAlignment = .center
        continueView.addSubview(priceLabel)
        priceLabel.anchor(top: continueBtn.bottomAnchor, leading: continueView.leadingAnchor, bottom: continueView.bottomAnchor, trailing: continueView.trailingAnchor, size: CGSize(width: continueView.frame.width * 0.8, height: 50))

    }
    
    @objc func buyTicketButtonAction(){
        var labelSeat: String = ""
        for seat in boughtSeat {
            labelSeat += "\(seat.key)-\(seat.value)|"
        }
        var ncData: [String:String] = [:]
        ncData["seats"] = labelSeat
        let buyTicketVC = BuyTicketViewController()
        buyTicketVC.delegate = self
        buyTicketVC.modalPresentationStyle = .formSheet
        buyTicketVC.addObserver()
        NotificationCenter.default.post(name: .Data, object: nil, userInfo: ncData)
        self.present(buyTicketVC, animated: true, completion: nil)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 44
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: SeatCollectionViewCell.identifier, for: indexPath) as? SeatCollectionViewCell
        myCell?.delegate = self
        if isExist(id: "\(indexPath.row)-1") || isExist(id: "\(indexPath.row)-0") {
            myCell?.configure(seatNumber: indexPath.row, type: isExist(id: "\(indexPath.row)-1") ? .man : .woman)
        } else {
            myCell?.configure(seatNumber: indexPath.row, type: .empty)
        }
        return myCell!
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SeatCollectionViewCell
        //MARK: -if that seat have selled, can't be touch.
        if cell?.seatType == .man || cell?.seatType == .woman {
            return
        }
        //MARK: -If the number of reservations is greater than 5
        if(!boughtSeat.keys.contains(indexPath.row) && boughtSeat.count >= 5) {
            let alert = UIAlertController(title: "Hata", message: "5'ten fazla koltuk seçemezsiniz", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //MARK: -Reservation control
        if(boughtSeat.keys.contains(indexPath.row)) {
            if let index = boughtSeat.keys.firstIndex(of: indexPath.row) {
                boughtSeat.remove(at: index)
            }
            cell?.seatType = .empty
        }else {
            cell?.chooseViewState = !(cell?.chooseViewState ?? false)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //MARK: -Some seats width increase for create hall
        return CGSize(width: indexPath.row % 4 == 1 ? self.view.frame.width / 3 : self.view.frame.width / SEAT_RATIO, height: self.view.frame.width / SEAT_RATIO)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 0)
    }
}

//MARK: -After buy ticket, update view delegate
extension ViewController: BuyTicketDelegate {
    func reloadData() {
        self.seatCollectionView?.reloadData()
        boughtSeat.removeAll()
    }
}

//MARK: - MAN: 1 | WOMAN: 0
extension ViewController: CellChooseDelegate {
    func buyError() {
        let alert = UIAlertController(title: "Hata", message: "Lütfen aynı cinsiyet yanından koltuk seçiniz.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    func chooseMan(id: Int) {
        boughtSeat[id] = 1
    }
    
    func chooseWoman(id: Int) {
        boughtSeat[id] = 0
    }
    
}
