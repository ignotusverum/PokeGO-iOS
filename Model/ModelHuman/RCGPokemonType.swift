//
//  RCGPokemonType.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

@objc(RCGPokemonType)
public class RCGPokemonType: _RCGPokemonType {

    // Database ID key
    static let databaseIDKey = "id"
    
	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext) throws -> RCGPokemonType? {

        return try RCGPokemonType.modelFetchWithID(objectID, context:context) as? RCGPokemonType
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext) throws -> RCGPokemonType? {

        return try RCGPokemonType.modelFetchOrInsertWithJSON(json, objectIDKey: databaseIDKey, context: context) as? RCGPokemonType
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, objectIDKey: String, context: NSManagedObjectContext) {

        super.setValueWithJSON(json, objectIDKey: objectIDKey, context: context)

        if let name = json["name"].string {
            self.name = name
        }
        
        if let urlString = json["url"].string {
            
            let result = urlString.sliceFrom("type/", to: "/")
            self.modelObjectID = result?.toInt()
        }
    }
}