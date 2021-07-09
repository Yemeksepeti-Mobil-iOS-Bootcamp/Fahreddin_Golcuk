//
//  ViewController.swift
//  coreDataHomework
//
//  Created by Fahreddin Gölcük on 9.07.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var cooks = [CookModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getCooks()
    }
    
    private func getCooks(){
        cooks.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { return }
                    guard let imageData = result.value(forKey: "image") as? Data, let image = UIImage(data: imageData) else { return }
                    guard let id = result.value(forKey: "id") as? UUID else { return }
                    cooks.append(CookModel(id: id, cookName: name, cookImage: image))
                }
                self.tableView.reloadData()
            }
        } catch {
            print("error")
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell",for: indexPath)
        cell.textLabel?.text = cooks[indexPath.row].cookName
        cell.imageView?.image = cooks[indexPath.row].cookImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteControl = UIAlertController(title: "Sil", message: "Bu yemeği silmek istediğinizden emin misiniz?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Evet", style: .default){ [self]_ in
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Cook")
                fetchRequest.predicate = NSPredicate(format: "id = %@", "\(self.cooks[indexPath.row].id)")
                do {
                    let results = try context.fetch(fetchRequest)
                    let resultData = results as! [NSManagedObject]
                    for object in resultData {
                        context.delete(object)
                    }
                    do {
                        try context.save()
                        print("TABLEVIEW-EDIT: saved!")
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    } catch {
                        // add general error handle here
                    }
                    try context.save()
                    self.cooks.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .bottom)
                    self.tableView.reloadData()
                } catch {
                    print("error")
                }
            }
            deleteControl.addAction(deleteAction)
            present(deleteControl, animated: true, completion: nil)
        }
    }
}



