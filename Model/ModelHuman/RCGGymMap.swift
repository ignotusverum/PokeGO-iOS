//
//  RCGGymMap.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

import MagicalRecord

@objc(RCGGymMap)
public class RCGGymMap: _RCGGymMap {

    // Database ID
    static let databaseIDKey = "identifier"
    
	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> RCGGymMap? {

        return try RCGGymMap.modelFetchWithID(objectID, context:context) as? RCGGymMap
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> RCGGymMap? {

        return try RCGGymMap.modelFetchOrInsertWithJSON(json, objectIDKey: databaseIDKey, context: context) as? RCGGymMap
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, objectIDKey: String, context: NSManagedObjectContext) {

        super.setValueWithJSON(json, objectIDKey: objectIDKey, context: context)

	    if self.modelObjectID != nil {

		 	if let _guardingID = json["guardingID"].int {
		 		self.guardingID = _guardingID
            }

		 	if let _identifier = json["identifier"].string {
		 		self.identifier = _identifier
            }

		 	if let _latitude = json["latitude"].double {
		 		self.latitude = _latitude
            }

		 	if let _longitude = json["longitude"].double {
		 		self.longitude = _longitude
            }

		 	if let _points = json["points"].int {
		 		self.points = _points
            }

		 	if let _team = json["team"].int {
		 		self.team = _team
            }

        }
    }
}