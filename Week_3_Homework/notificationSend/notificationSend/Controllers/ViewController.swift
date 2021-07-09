//
//  ViewController.swift
//  notificationSend
//
//  Created by Fahreddin Gölcük on 9.07.2021.
//

import UIKit

class ViewController: UIViewController {

    private let nameField = UITextField(frame: CGRect(x: 0, y: 100, width: 250, height: 40))
    private let surnameField = UITextField(frame: CGRect(x: 0, y: 200, width: 250, height: 40))
    
    
    private var user: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        nameField.placeholder = "Enter name here"
        nameField.center.x = view.center.x
        nameField.layer.cornerRadius = CGFloat(16)
        nameField.backgroundColor = .brown
        view.addSubview(nameField)
        
        
        surnameField.placeholder = "Enter surname here"
        surnameField.center.x = view.center.x
        surnameField.layer.cornerRadius = CGFloat(16)
        surnameField.backgroundColor = .brown
        view.addSubview(surnameField)
        
        
        let sendButton = UIButton()
        sendButton.setTitle("SEND DATA", for: .normal)
        sendButton.backgroundColor = .blue
        sendButton.frame = CGRect(x: 0, y: self.view.bounds.height - 100, width: 100, height: 50)
        sendButton.layer.zPosition = 4
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        sendButton.center.x = self.view.center.x
        sendButton.layer.cornerRadius = CGFloat(10)
        self.view.addSubview(sendButton)
    }
    
    @objc private func didTapSendButton(){
        user["name"] = nameField.text
        user["surname"] = surnameField.text
        let receiveVC = ReceiveViewController()
        receiveVC.addObserver()
        NotificationCenter.default.post(name: .Data, object: nil, userInfo: user)
        present(receiveVC, animated: true, completion: nil)
    }
}
