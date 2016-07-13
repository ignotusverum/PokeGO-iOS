//
//  RCGSynchronizerHandler.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 7/13/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

import CoreData
import SVProgressHUD

let RCGSynchronizerHandlerSynchronizedNotificationKey = "RCGSynchronizerHandlerSynchronizedNotificationKey"

class RCGSynchronizerHandler: NSObject {
    // MARK: - Properties
    
    var showProgress = false
    
    var dataAdaptersArray: Array<RCGSynchronizerAdapter>?
    
    static let sharedSynchronizer = TCGSynchronizerHandler()
    
    var synchronized: Bool = false
    
    var context: NSManagedObjectContext {
        get {
            
            return NSManagedObjectContext.MR_defaultContext()
        }
    }
    
    // MARK: - Synchronization logic
    // synchronizing all adapters
    func resynchronize() {
        
        self.synchronized = false
        
        guard let _dataAdaptersArray = self.dataAdaptersArray else {
            
            return
        }
        
        if _dataAdaptersArray.count > 0 {
            for adapter in _dataAdaptersArray {
                
                adapter.synchronizeData()
            }
        }
    }
    
    func addAdapter(adapter: RCGSynchronizerAdapter) {
        
        if self.dataAdaptersArray != nil {
            
            adapter.delegate = self
            self.dataAdaptersArray!.append(adapter)
        }
    }
    
    func adapterDidSynchronized(adapter: RCGSynchronizerAdapter) {
        
        guard let _dataAdaptersArray = self.dataAdaptersArray else {
            
            return
        }
        
        var synchronized = true
        
        if self.showProgress {
            SVProgressHUD.setBackgroundColor(UIColor.blackColor())
            SVProgressHUD.show()
        }
        
        if _dataAdaptersArray.count > 0 {
            
            for adapter in _dataAdaptersArray {
                if !adapter.synchronized {
                    synchronized = false
                }
                
                print("--------------------")
                print(adapter, adapter.synchronized)
            }
        }
        
        self.synchronized = synchronized
        
        if self.synchronized {
            
            SVProgressHUD.dismiss()
            
            NSNotificationCenter.defaultCenter().postNotificationName(RCGSynchronizerHandlerSynchronizedNotificationKey, object: nil)
        }
    }
}
