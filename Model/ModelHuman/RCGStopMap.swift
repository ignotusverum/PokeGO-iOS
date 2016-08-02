//
//  RCGStopMap.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

@objc(RCGStopMap)
public class RCGStopMap: _RCGStopMap {
    
    // Database ID key
    static let databaseIDKey = "spawnpoint_id"

	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: String, context: NSManagedObjectContext) throws -> RCGStopMap? {

        return try RCGStopMap.modelFetchWithID(objectID, context:context) as? RCGStopMap
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> RCGStopMap? {
        
        return try self.fetchOrInsertWithJSONString(json, objectIDKey: databaseIDKey) as? RCGStopMap
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, objectIDKey: String, context: NSManagedObjectContext) {

	    super.setValueWithJSON(json, objectIDKey: objectIDKey, context: context)

	    if self.modelObjectID != nil {

		 	if let _latitude = json["latitude"].double {
		 		self.latitude = _latitude
            }

		 	if let _longitude = json["longitude"].double {
		 		self.longitude = _longitude
            }

//		 	if let _lureExpiration = json["lureExpiration"]. {
//		 		self.lureExpiration = _lureExpiration
//            }

		 	if let _luredPokemonID = json["luredPokemonID"].int {
		 		self.luredPokemonID = _luredPokemonID
            }

		 	if let _stopID = json["stopID"].string {
		 		self.stopID = _stopID
            }
        }
    }
}