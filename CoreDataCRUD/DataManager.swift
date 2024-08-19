//
//  DataManager.swift
//  CoreDataCRUD
//
//  Created by Shan Havilah on 16/08/24.
//

import Foundation
import CoreData

class DataManager{
    
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataCRUD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func createActivity (title: String, type: String, location: String, deskripsi: String, date: Date) -> Activity{
        let activity = Activity(context: persistentContainer.viewContext)
        activity.title = title
        activity.type = type
        activity.location = location
        activity.deskripsi = deskripsi
        activity.date = date
        return activity
    }
    
    func readActivity () -> [Activity] {
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        
        var fetchedActivities: [Activity] = []
        
        do{
            fetchedActivities = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error")
        }
        return fetchedActivities
    }
    
    func updateActivity (activity: Activity, newTitle: String, newType: String) {
        activity.title = newTitle
        activity.type = newType
    }
    
    func deleteActivity (activity: Activity) {
        persistentContainer.viewContext.delete(activity)
    }
    
    // MARK: - Core Data Saving support

    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
