//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Shan Havilah on 16/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    var angka = UserDefaults.standard.integer(forKey: "TotalMasukData")
    
    private var activity: [Activity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createData(_ sender: Any) {
        let aktivitas = DataManager.shared.createActivity(title: "Aktivitas \(angka)", type: "Tipe online \(angka)", location: "alamat \(angka)", deskripsi: "lorem", date: Date())
        activity.append(aktivitas)
        DataManager.shared.save()
        angka += 1
    }
    
    
    @IBAction func readData(_ sender: Any) {
        activity = DataManager.shared.readActivity()
        activity.forEach { aktiviti in
            print("Title: \(aktiviti.title!)")
            print("Type: \(aktiviti.type!)")
            print("Location: \(aktiviti.location!)")
            print("Description: \(aktiviti.deskripsi)")
            print("Date: \(aktiviti.date!)")
            print("")
            print("")
        }
    }
    
    
    @IBAction func updateData(_ sender: Any) {
        DataManager.shared.updateActivity(activity: activity.last!, newTitle: "Updated", newType: "Offline")
        DataManager.shared.save()
    }
    
    @IBAction func deleteData(_ sender: Any) {
        DataManager.shared.deleteActivity(activity: activity.last!)
        DataManager.shared.save()
    }
    
}

