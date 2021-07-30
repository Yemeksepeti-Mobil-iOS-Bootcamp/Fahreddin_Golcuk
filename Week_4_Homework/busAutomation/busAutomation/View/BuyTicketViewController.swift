//
//  BuyTicketViewController.swift
//  busAutomation
//
//  Created by Fahreddin Gölcük on 22.07.2021.
//

import UIKit

protocol BuyTicketDelegate {
    func reloadData()
}

class BuyTicketViewController: UIViewController {
    var delegate: BuyTicketDelegate?
    
    var ticket: Ticket = Ticket()
    
    let stackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.alignment = .fill
        v.distribution = .fill
        v.spacing = 0
        return v
    }()
    
    var boughtSeat: [Int:Int] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let ticketLbl: UILabel = UILabel()
        ticketLbl.text = "PASSENGER INFORMATION"
        ticketLbl.font = UIFont.boldSystemFont(ofSize: 18)
        ticketLbl.textAlignment = .center
        ticketLbl.backgroundColor = .lightGray
        view.addSubview(ticketLbl)
        ticketLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: view.frame.width, height: 60))
        
        let nameSurnameInput: UITextField = UITextField()
        nameSurnameInput.backgroundColor = .systemGray6
        nameSurnameInput.placeholder = "Passenger name and surname"
        nameSurnameInput.delegate = self
        nameSurnameInput.layer.cornerRadius = 8
        view.addSubview(nameSurnameInput)
        nameSurnameInput.anchor(top: ticketLbl.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: view.frame.width, height: 60),padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        view.addSubview(datePicker)
        datePicker.anchor(top: nameSurnameInput.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: view.frame.width, height: 60))
        
        let buyTicketBtn: UIButton = UIButton()
        buyTicketBtn.setTitle("Buy Ticket", for: .normal)
        buyTicketBtn.backgroundColor = .systemGreen
        buyTicketBtn.layer.cornerRadius = 16
        buyTicketBtn.addTarget(self, action: #selector(buyTicketAction), for: .touchUpInside)
        view.addSubview(buyTicketBtn)
        buyTicketBtn.anchor(top: datePicker.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: view.frame.width / 3, height: 60), padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        print(picker.date)
        ticket.date = picker.date
    }
    
    @objc func buyTicketAction() {
        for seat in boughtSeat {
            ticket.seats.append(Seat(type: seat.value == 0 ? .woman : .man, seatNumber: seat.key))
            insertToEntity(id: "\(seat.key)-\(seat.value)")
        }
        ticket.seatCount = boughtSeat.count
        print(ticket.printTicket())
        delegate?.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceive(notification:)), name: .Data, object: nil)
    }
        
    @objc func notificationReceive(notification: NSNotification){
        if let _ticketLbl = notification.userInfo?["seats"] as? String {
            let seats = _ticketLbl.components(separatedBy: "|")
            for seat in seats {
                let number = seat.components(separatedBy: "-") as [String]
                if(number[0].isNumber) {
                    let key = Int(number[0])
                    let value = Int(number[1])
                    boughtSeat[key ?? 0] = value
                }
            }
        }
    }
}

extension BuyTicketViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        ticket.passenger.fullName = textField.text ?? ""
    }
}

