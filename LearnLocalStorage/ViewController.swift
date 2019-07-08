//
//  ViewController.swift
//  LearnLocalStorage
//
//  Created by Indra Sumawi on 05/07/19.
//  Copyright © 2019 Indra Sumawi. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let text = UserDefaults.standard.string(forKey: "name")
//        nameLabel.text =  text
        nameLabel.text = ""
        fetchData()
    }
    func fetchData () {
        
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        //2
        var users = [User]()
        
        do {
           users = try managedContext.fetch(User.fetchRequest())
            
            for user in users {
                let name = user.name
                let age = user.age
                
                nameLabel.text! += "\(name!) \(age), "
                print(name!)
            }
            
            
        } catch  {
            print("Gagal Memanggil")
        }
        
        
        
    }
    


    @IBAction func save(_ sender: UIButton) {
        
//        nameLabel.text = nameField.text
//        UserDefaults.standard.set(nameLabel.text, forKey: "name")
        
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return  }
        
        //2
        let user = User(context: managedContext)
        
        user.name = nameField.text
        user.age = Int32(ageField.text!)!
        
        do {
            try managedContext.save()
            print("Berhasil di simpan")
        } catch  {
            print("Gagal menyimpan")
        }
        
    }
}

