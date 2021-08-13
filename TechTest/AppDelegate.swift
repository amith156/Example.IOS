//
//  AppDelegate.swift
//  TechTest
//
//  Created by Alex Jackson on 01/03/2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         print(urls[urls.count-1] as URL)

        return true
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        NotificationCenter.default.post(name: NSNotification.Name("PostData"), object: nil)
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.coreDataSharedManager.saveContext()
        
    }
    
    
}


