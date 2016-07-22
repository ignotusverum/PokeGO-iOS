//
//  RCGModel.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

import MagicalRecord

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
    
    class func modelFetchWithName(objectName: String, context: NSManagedObjectContext) throws -> AnyObject? {
        
        var result: AnyObject?
        
        let fetchRequest = NSFetchRequest(entityName: self.entityName())
        let predicate = NSPredicate(format:"%K == %i", RCGModelAttributes.name.rawValue, objectName)
        
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
        else if let modelName = json["name"].string {
            result = try self.modelFetchWithName(modelName, context: context)
            
            if result == nil {
                
                result = self.MR_createInContext(context)
            }
            
            (result as? RCGModel)?.setValueWithJSON(json, context: context)
        }
    
        return result
    }
    
    class func modelFetchOrInsertDefaultWithJSON(json: JSON) throws-> AnyObject? {

        return try self.modelFetchOrInsertWithJSON(json, context: NSManagedObjectContext.MR_defaultContext())
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