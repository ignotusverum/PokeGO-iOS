//
//  RCGSynchronizerAdapter.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 7/13/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

protocol RCGSynchronizerAdapterDelegate {
    
    func adapterDidSynchronized(adapter: RCGSynchronizerAdapter)
}

class RCGSynchronizerAdapter: NSObject {
    // MARK: - Delegates
    var delegate: RCGSynchronizerAdapterDelegate?
    
    // MARK: - Properties
    var synchronized = false
    
    var updateNotificationKey: String?
    
    // MARK: - Initialization methods
    
    class func modelName()-> String {
        
        return ""
    }
    
    class func updatedNotificationKey()-> String {
        
        return String(format: "TMSynchronizerAdapterUpdateNotificationFor%@", self.modelName())
    }
    
    class func postUpdateNoticiation(objectID: String?) {
        
        guard let _objectID = objectID else {
            
            print("objectID in update call is nil")
            return
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(self.updatedNotificationKey(), object: nil, userInfo: ["objectID": _objectID])
    }
    
    // MARK: - Synchronization logic
    
    func synchronizeData() {
        
        self.synchronized = true
        
        if self.delegate != nil {
            self.delegate?.adapterDidSynchronized(self)
        }
    }
}
