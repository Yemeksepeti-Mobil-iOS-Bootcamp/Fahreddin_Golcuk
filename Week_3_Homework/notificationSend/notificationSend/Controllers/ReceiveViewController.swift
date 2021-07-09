//
//  ReceiveViewController.swift
//  notificationSend
//
//  Created by Fahreddin Gölcük on 9.07.2021.
//

import UIKit

class ReceiveViewController: UIViewController {
    var name = UILabel()
    var surname = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Your Informations"
        
        name.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        name.font = UIFont.systemFont(ofSize: 30)
        name.textAlignment = .center
        self.view.addSubview(name)
        
        surname.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height)
        surname.font = UIFont.systemFont(ofSize: 30)
        surname.textAlignment = .center
        self.view.addSubview(surname)
        
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceive(notification:)), name: .Data, object: nil)
    }
        
    @objc func notificationReceive(notification: NSNotification){
        if let _name = notification.userInfo?["name"] as? String {
                 name.text = _name
        }
        
        if let _surname = notification.userInfo?["surname"] as? String {
                 surname.text = _surname
        }
    }
    
}
