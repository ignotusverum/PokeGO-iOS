//
//  RCGPokemonMap.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

import CoreLocation

public class RCGPokemonMap: _RCGPokemonMap {
    
    // Flag to show, if not dissapeared
    var avaliable = false
    
    // Location
    var location: CLLocationCoordinate2D? {
        get {
            
            // Safety check
            guard let latitude = self.latitude, let longitude = self.longitude else {
                
                return nil
            }
            
            return CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)
        }
    }
    
    // Dissapear Time
    var dissapearDate: NSDate? {
        didSet {
            // Safety check
            guard let dissapearDate = dissapearDate else {
                return
            }
    
            let currentDate = NSDate()
            
            if currentDate < dissapearDate {
                // In the present
                self.avaliable = false
            }
            else {
                // In the future
                self.avaliable = true
            }
        }
    }
    
    var dissapearTime: Int? {
        didSet {
            
            // Safety check
            guard let dissapearTime = dissapearTime else {
                return
            }
            
            // Milli / 1000 = sec
            let timeInSec: NSTimeInterval = Double(dissapearTime / 1000)
            
            // Date
            let dateFromTime = NSDate(timeIntervalSince1970: timeInSec)
            
            self.dissapearDate = dateFromTime
        }
    }
    
    // MARK: - Fetching logic
    class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext) throws -> RCGPokemonMap? {
        
        return try RCGPokemonMap.modelFetchWithID(objectID, context:context) as? RCGPokemonMap
    }
    
    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> RCGPokemonMap? {
        
        var result: AnyObject?
        
        if let modelObjectID = json["pokemon_id"].int {
            
            result = try self.modelFetchWithID(modelObjectID, context: context)
            
            if result == nil {
                
                result = self.MR_createInContext(context)
            }
            
            (result as? RCGModel)?.setValueWithJSON(json, context: context)
        }
        
        return result as? RCGPokemonMap
    }
    
    class func fetchOrInsertWithJSON(json: JSON) throws -> RCGPokemonMap? {
        
        return try RCGPokemonMap.modelFetchOrInsertDefaultWithJSON(json) as? RCGPokemonMap
    }
    
    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, context: NSManagedObjectContext) {

        if let modelID = json["pokemon_id"].int {
            
            self.modelObjectID = modelID
            
            if let _name = json["pokemon_name"].string {
                
                self.name = _name
            }
            
            if let _disappearTime = json["disappear_time"].int {
                self.dissapearTime = _disappearTime
            }
            
            if let _encounterID = json["encounter_id"].string {
                self.encounterID = _encounterID
            }
            
            if let _latitude = json["latitude"].double {
                self.latitude = _latitude
            }
            
            if let _longitude = json["longitude"].double {
                self.longitude = _longitude
            }
            
            if let _spawnpointID = json["spawnpointID"].string {
                self.spawnpointID = _spawnpointID
            }
        }
    }
}