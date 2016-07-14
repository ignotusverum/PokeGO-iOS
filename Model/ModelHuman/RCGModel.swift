//
//  RCGModel.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

@objc(RCGModel)
public class RCGModel: _RCGModel {

    var json: JSON?
    
    class func modelFetchWithID(objectID: Int, context: NSManagedObjectContext) throws -> AnyObject? {
        
        var result: AnyObject?
        
        let fetchRequest = NSFetchRequest(entityName: self.entityName())
        let predicate = NSPredicate(format:"%K == %i", RCGModelAttributes.modelObjectID.rawValue, objectID)
        
        fetchRequest.predicate = predicate
        
        let results = try context.executeFetchRequest(fetchRequest)
        result = results.first
        
        return result
    }
    
    class func modelFetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext) throws -> AnyObject? {
        
        var result: AnyObject?
        
        if let modelObjectID = json["id"].int {
            
            result = try self.modelFetchWithID(modelObjectID, context: context)
            
            if result == nil {
                
                result = self.MR_createInContext(context)
            }
            
            (result as? RCGModel)?.setValueWithJSON(json, context: context)
        }
        
        return result
    }
    
    func setValueWithJSON(json: JSON, context: NSManagedObjectContext) {
        
        self.json = json
        
        if let modelObjectID = json["id"].int {
            
            self.modelObjectID = modelObjectID
        }
    }
    
    // MARK: - Utilities
    
    func convertStringToJSON(text: String) -> JSON? {
        
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                
                return JSON(json!)
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}