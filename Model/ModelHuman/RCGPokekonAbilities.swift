//
//  RCGPokekonAbilities.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

@objc(RCGPokekonAbilities)
public class RCGPokekonAbilities: _RCGPokekonAbilities {

	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext) throws -> RCGPokekonAbilities? {

        return try RCGPokekonAbilities.modelFetchWithID(objectID, context:context) as? RCGPokekonAbilities
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext) throws -> RCGPokekonAbilities? {

        return try RCGPokekonAbilities.modelFetchOrInsertWithJSON(json, context: context) as? RCGPokekonAbilities
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, context: NSManagedObjectContext) {

	    super.setValueWithJSON(json, context: context)

	    if self.modelObjectID != nil {
            
        }
    }
}