//
//  AdressViewController.swift
//  mePinned
//
//  Created by Fahreddin Gölcük on 9.07.2021.
//

import UIKit

class AddressViewController: UIViewController {

    var cityLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Your Address"
        
        cityLbl.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        cityLbl.font = UIFont.systemFont(ofSize: 30)
        cityLbl.numberOfLines = 10
        cityLbl.textAlignment = .center
        self.view.addSubview(cityLbl)
        
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceive(notification:)), name: .Address, object: nil)
    }
        
    @objc func notificationReceive(notification: NSNotification){
        if let dictionary = notification.userInfo as? Dictionary<String, String> {
            cityLbl.text = """
                            Ülke: \(dictionary["country"] ?? "")
                            İl: \(dictionary["city"] ?? "")
                            İlçe: \(dictionary["locality"] ?? "")
                            Mahalle: \(dictionary["subLocality"] ?? "")
                            Sokak: \(dictionary["street"] ?? "")
                            Posta Kodu: \(dictionary["postalCode"] ?? "")
                            Kapı Numarası: \(dictionary["doorNumber"] ?? "")
                           """
        }
    }
}
