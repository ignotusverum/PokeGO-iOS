//
//  RCGPokemonMap.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

@objc(RCGPokemonMap)
public class RCGPokemonMap: _RCGPokemonMap {

    // Override
    override class func modelFetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext) throws -> AnyObject? {
        
        var result: AnyObject?
        
        if let modelObjectID = json["pokemon_id"].int {
            
            result = try self.modelFetchWithID(modelObjectID, context: context)
            
            if result == nil {
                
                result = self.MR_createInContext(context)
            }
            
            (result as? RCGModel)?.setValueWithJSON(json, context: context)
        }
        
        return result
    }
    
	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext) throws -> RCGPokemonMap? {

        return try RCGPokemonMap.modelFetchWithID(objectID, context:context) as? RCGPokemonMap
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext) throws -> RCGPokemonMap? {

        return try RCGPokemonMap.modelFetchOrInsertWithJSON(json, context: context) as? RCGPokemonMap
    }
    
    class func fetchOrInsertWithJSON(json: JSON) throws -> RCGPokemonMap? {
        
        return try RCGPokemonMap.modelFetchOrInsertDefaultWithJSON(json) as? RCGPokemonMap
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, context: NSManagedObjectContext) {

	    super.setValueWithJSON(json, context: context)

        if let _modelObjetID = json["pokemon_id"].int {
            
            self.modelObjectID = _modelObjetID
            
            if let _name = json["pokemon_name"].string {
                
                self.name = _name
            }
            
            if let _disappearTime = json["disappear_time"].int {
                self.disappearTime = _disappearTime
            }
            
            if let _encounterID = json["encounter_id"].string {
                self.encounterID = _encounterID
            }
            
            if let _latitude = json["latitude"].float {
                self.latitude = _latitude
            }
            
            if let _longitude = json["longitude"].float {
                self.longitude = _longitude
            }
            
            if let _spawnpointID = json["spawnpointID"].int {
                self.spawnpointID = _spawnpointID
            }
        }
    }
}