//
//  DBHelper.swift
//  CoreDataDM
//
//  Created by Jitendra on 8/2/17.
//  Copyright © 2017 Jitendra. All rights reserved.
//

import UIKit
import CoreData
class DBHelper: NSObject {

  // Function To store Data
    
    class func saveRecords(_ name: String, email: String, address: String, phone:Int, pin:Int)->Bool{
       
        var result: Bool = false
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let managerDetails : Users?      =  NSEntityDescription.insertNewObject(forEntityName: "Users", into:managedContext) as? Users
        if let objUser = managerDetails
            {
                objUser.name = name as String
                objUser.email = email as String
                objUser.aboutUS = address as String
                objUser.phone = Int64(phone)
                objUser.pin = Int64(pin)
                do {
                    try objUser.managedObjectContext?.save()
                    result = true
                } catch {
                    result =  false
                    let saveError = error as NSError
                    print(saveError)
                }
                
            
        }
        
       
        return result
        
        
    }
    
    
    // Update the record
    
    class func updateRecords(_ name: String, email: String, address: String, phone:Int, pin:Int)->Bool{
         var arrResult: [AnyObject]?
        var isUpdate: Bool = false
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users", in:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate
        
        do {
            
            arrResult =   try managedContext.fetch(fetchRequest)
            if let arrData = arrResult
            {
                
                let objUser  = arrData[0]  as! Users
                
                objUser.name = name as String
                objUser.email = email as String
                objUser.aboutUS = address as String
                objUser.phone = Int64(phone)
                objUser.pin = Int64(pin)
                try  appDel.managedObjectContext.save()
                isUpdate = true
            }
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        
        return isUpdate
    }
    
   // Fetch Records
    class func JAFetchAllRecords()->[AnyObject]!
    {
        var result: [AnyObject]?
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users", in:managedContext)
        fetchRequest.entity = entityDescription
        do
        {
            try result = managedContext.fetch(fetchRequest)
            
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        return result!
    }
    
// alredy email store
    class func isAlredyEmail(_email: String)->Bool{
        var result: [AnyObject];
        var isExist: Bool?
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users", in:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "email == %@", _email)
        fetchRequest.predicate = predicate
        do
        {
            try result = managedContext.fetch(fetchRequest)
           
            if result.count > 0 {
              isExist = true
            }else{
                isExist = false
            }
            
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        return isExist!
   
    }
    
    // Delete the record.
    
    class func deleteRecord(_ email: String)->Bool{
        var arrResult: [AnyObject]?;
        var isDelete = false
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "Users", in:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "email == %@", email )
        fetchRequest.predicate = predicate
        
        do {
            
            arrResult =   try managedContext.fetch(fetchRequest)
            
            if let arrData = arrResult
            {
                for result: AnyObject in arrData{
                    
                    appDel.managedObjectContext.delete(result as! NSManagedObject)
                }
                try appDel.managedObjectContext.save()
                
                isDelete = true
            }
            
        }
        catch let error as NSError {
            // failure
            isDelete = false
            print("Fetch failed: \(error.localizedDescription)")
        }
        return isDelete
    }
   
    }

