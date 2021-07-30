//
//  Functions.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 28.07.2021.
//

import Foundation
import CoreData
import UIKit

func deleteFromEntity(id: Int) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Games")
    fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
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
    } catch {
        print("error")
    }
}

func insertToEntity(id: Int) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    let game = NSEntityDescription.insertNewObject(forEntityName: "Games", into: context)
    
    //MARK: -APPEND TO CORE DATA
    game.setValue(id, forKey: "id")
    do {
        try context.save()
    } catch  {
        print("Not saved.")
    }
}

func isExist(id: Int?) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
    
    do {
        let results = try context.fetch(fetchRequest)
        if results.count > 0 {
            for result in results as! [NSManagedObject] {
                guard let entityId = result.value(forKey: "id") as? Int else { return false }
                if(entityId == id ?? 0){
                    return true
                }
            }
        }
        return false
    } catch {
        return false
    }
}
