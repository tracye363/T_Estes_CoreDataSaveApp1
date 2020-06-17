//
//  ViewController.swift
//  T_E_CoreDataSave1
//
//  Created by Tracy Estes on 6/17/20.
//  Copyright © 2020 Tracy Estes. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    

    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var schoolTextField: UITextField!
    
    @IBOutlet var outputNameTextField: UILabel!
    
    @IBOutlet var outputSchoolTextField: UILabel!
    
    @IBOutlet var outputSubjectTextField: UILabel!
    
    @IBOutlet var subjectTextField: UITextField!
    
    @IBAction func saveNameButton(_ sender: UIButton) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(nameTextField.text!, forKey: "name")
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print ("Error saving name")
        }
        outputNameTextField.text?.removeAll()
        nameTextField.text?.removeAll()
        fetchData()
        
        newEntity.setValue(schoolTextField.text!, forKey: "school")
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print ("Error saving data")
        }
        outputSchoolTextField.text?.removeAll()
        schoolTextField.text?.removeAll()
        fetchData2()
        
        newEntity.setValue(subjectTextField.text!, forKey: "subject")
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print ("Error saving data")
        }
        outputSubjectTextField.text?.removeAll()
        subjectTextField.text?.removeAll()
        fetchData3()
        
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        let deleteName = nameTextField.text!
       
        for item in listArray {
            if item.value(forKey: "name") as! String == deleteName {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch {
                print ("Error deleting data")
            }
            outputNameTextField.text?.removeAll()
            nameTextField.text?.removeAll()
            fetchData()
            
            }
            
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        outputNameTextField.text?.removeAll()
        outputSchoolTextField.text?.removeAll()
        outputSubjectTextField.text?.removeAll()
        fetchData()
        fetchData2()
        fetchData3()
    }
    func fetchData() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "name") as! String
                outputNameTextField.text! += product
            }
        } catch {
            print ("Error retrieving name")
        }
    }
    func fetchData2() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "school") as! String
                outputSchoolTextField.text! += product
            }
        } catch {
            print ("Error retrieving school name")
        }
    }
    func fetchData3() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "subject") as! String
                outputSubjectTextField.text! += product
            }
        } catch {
            print ("Error retrieving subject")
        }
    }
}


