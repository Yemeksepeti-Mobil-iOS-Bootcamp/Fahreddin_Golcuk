//
//  CookCreateViewController.swift
//  coreDataHomework
//
//  Created by Fahreddin Gölcük on 10.07.2021.
//

import UIKit
import CoreData

class CookCreateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var cookImage: UIImageView!
    @IBOutlet weak var cookName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cookImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        cookImage.addGestureRecognizer(tapRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func choosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cookImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cookAdd(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let newCook = NSEntityDescription.insertNewObject(forEntityName: "Cook", into: context)
        newCook.setValue(cookName.text, forKey: "name")
        newCook.setValue(UUID(), forKey: "id")
        let imageData = cookImage.image?.jpegData(compressionQuality: 0.5)
        newCook.setValue(imageData, forKey: "image")
        do {
            try context.save()
        } catch {
            print("Kaydedilmedi")
        }
        self.navigationController?.popViewController(animated: true)
    }
}
