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
    
    class func modelFetchWithID(objectID: String, context: NSManagedObjectContext) throws -> AnyObject? {
        
        return nil
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
    
    class func fetchOrInsertWithJSONString(json: JSON, objectIDKey: String, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> RCGModel? {
        
        var result: RCGModel?
        
        if let modelObjectID = json[objectIDKey].string {
            
            result = try self.modelFetchWithID(modelObjectID, context: context) as? RCGModel
            
            if result == nil {
                
                result = self.MR_createInContext(context) as? RCGPokemonMap
            }
            
            result?.setValueWithJSON(json, objectIDKey: objectIDKey, context: context)
        }
        
        return result
    }
    
    class func modelFetchOrInsertWithJSON(json: JSON, objectIDKey: String, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> AnyObject? {
        
        var result: AnyObject?
        
        if let modelObjectID = json[objectIDKey].int {
        
            result = try self.modelFetchWithID(modelObjectID, context: context)
            
            if result == nil {
                
                result = self.MR_createInContext(context)
            }
            
            (result as? RCGModel)?.setValueWithJSON(json, objectIDKey: objectIDKey, context: context)
        }
        
        return result
    }
    
    func setValueWithJSON(json: JSON, objectIDKey: String, context: NSManagedObjectContext) {
        
        self.json = json
        
        if let modelObjectID = json[objectIDKey].int {
            
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