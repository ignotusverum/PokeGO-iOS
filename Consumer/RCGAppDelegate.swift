//
//  AppDelegate.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/12/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

import CoreData

import MagicalRecord

@UIApplicationMain
class RCGAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Core Data
    var storeURL: NSURL?
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Setup database
        self.setupDB()
        
        print("store filepath ", NSPersistentStore.MR_urlForStoreName(MagicalRecord.defaultStoreName()))
        
        return true
    }
    
    // MARK: - Core data
    func setupDB() {
        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed(self.dbStore())
    }
    
    func dbStore() -> String {
        return "\(self.bundleID()).sqlite"
    }
    
    func bundleID() -> String {
        return NSBundle.mainBundle().bundleIdentifier!
    }
}
