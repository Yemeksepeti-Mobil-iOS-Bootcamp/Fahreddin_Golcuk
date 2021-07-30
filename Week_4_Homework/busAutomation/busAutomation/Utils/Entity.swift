//
//  Entity.swift
//  busAutomation
//
//  Created by Fahreddin Gölcük on 30.07.2021.
//

import Foundation

import CoreData
import UIKit

func insertToEntity(id: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    let bus = NSEntityDescription.insertNewObject(forEntityName: "Bus", into: context)
    
    //MARK: -APPEND TO CORE DATA
    bus.setValue(id, forKey: "busSeat")
    do {
        try context.save()
        print("context saved",id)
    } catch  {
        print("Not saved.")
    }
}

func isExist(id: String?) -> Bool {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bus")
    
    do {
        let results = try context.fetch(fetchRequest)
        if results.count > 0 {
            for result in results as! [NSManagedObject] {
                guard let entityId = result.value(forKey: "busSeat") as? String else { return false }
                if(entityId == id ?? ""){
                    return true
                }
            }
        }
        return false
    } catch {
        return false
    }
}


func deleteAllRecords() {
       //delete all data
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
       let context = appDelegate.persistentContainer.viewContext
       let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Bus")
       let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

       do {
           try context.execute(deleteRequest)
           try context.save()
       } catch {
           print ("There was an error")
       }
   }

