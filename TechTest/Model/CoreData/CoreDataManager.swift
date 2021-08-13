//
//  CoreDataManager.swift
//  TechTest
//
//  Created by Amith Narayan on 13/08/2021.
//

import Foundation
import CoreData

class CoreDataManager {
    //1
    static let coreDataSharedManager = CoreDataManager()
    //2.
    private init() {}
    
    //3
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostListModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //4
    func saveContext () {
        let context = CoreDataManager.coreDataSharedManager.persistentContainer.viewContext
        
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
    
    
    //MARK:- fetch all items
    func fetchAllSaveItems() -> [PostListEntity]?{
        
        
        /*Before you can do anything with Core Data, you need a managed object context. */
        let managedContext = CoreDataManager.coreDataSharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PostListEntity")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [PostListEntity]
        } catch let error as NSError {
            print("-----> Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    //MARK:- add operation
    func insert(post: Post) -> PostListEntity? {
        let managedContext = CoreDataManager.coreDataSharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PostListEntity",
        in: managedContext)!
        let postItem = NSManagedObject(entity: entity, insertInto: managedContext)
        postItem.setValue(post.id, forKey: "id")
        postItem.setValue(post.title, forKey: "title")
        postItem.setValue(post.body, forKey: "body")
        
        do {
            try managedContext.save()
            return postItem as? PostListEntity
            
        } catch let error as NSError {
            print("-----> Could not save. \(error), \(error.userInfo)")
            return nil
        }
        
        
//        inventoryItem.setValue(name, forKey: "name")
    }
    
    
    //MARK:- Update opertion
    func update(name:String, postListEntity : PostListEntity) {
        
        let context = CoreDataManager.coreDataSharedManager.persistentContainer.viewContext
      
        postListEntity.setValue(name, forKey: "name")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func update(itemName : String, postListEntity : PostListEntity ) {
        
        CoreDataManager.coreDataSharedManager.update(name: itemName, postListEntity: postListEntity)
    }
    
    
    //MARK:- delete
    func delete(postListItem : PostListEntity){
        let managedContext = CoreDataManager.coreDataSharedManager.persistentContainer.viewContext
        managedContext.delete(postListItem)
      do {
        try managedContext.save()
      } catch {
        // Do something in response to error condition
      }
    }
    
    
    
    
    
    
}
