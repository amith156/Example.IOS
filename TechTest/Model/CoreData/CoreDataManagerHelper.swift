//
//  CoreDataManagerHelper.swift
//  TechTest
//
//  Created by Amith Narayan on 13/08/2021.
//

import Foundation
import CoreData

class CoreDataManagerHelper {
    
    var postArrayList : [NSManagedObject] = []
    static let coreDataSharedManagerVM = CoreDataManagerHelper()
    
    
    func insertNewData(itemName : Post) {
        let item = CoreDataManager.coreDataSharedManager.insert(post: itemName)
        if item != nil {
            postArrayList.append(item!)
        }
    }

    func update(itemName : String, postListEntity : PostListEntity ) {
        CoreDataManager.coreDataSharedManager.update(name: itemName, postListEntity: postListEntity)
    }
    
    func fetchSetupAllItems(){
      if CoreDataManager.coreDataSharedManager.fetchAllSaveItems() != nil{
        postArrayList = CoreDataManager.coreDataSharedManager.fetchAllSaveItems()!
      }
    }

    func delete(postListEntity : PostListEntity) {
        CoreDataManager.coreDataSharedManager.delete(postListItem : postListEntity)
    }
    
//    func returnInventoryArrayListString() -> [String] {
//        var list : [String] = []
//        for val in postArrayList {
//            var x = val.value(forKeyPath: "name") as! String
//            list.append(x)
//        }
//        print("///// ",list)
//        return list
//    }
    
    
}
