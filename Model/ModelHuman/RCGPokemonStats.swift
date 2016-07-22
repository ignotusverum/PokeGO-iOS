//
//  RCGPokemonStats.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

@objc(RCGPokemonStats)
public class RCGPokemonStats: _RCGPokemonStats {

	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext) throws -> RCGPokemonStats? {

        return try RCGPokemonStats.modelFetchWithID(objectID, context:context) as? RCGPokemonStats
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext) throws -> RCGPokemonStats? {

        return try RCGPokemonStats.modelFetchOrInsertWithJSON(json, context: context) as? RCGPokemonStats
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, context: NSManagedObjectContext) {

	    super.setValueWithJSON(json, context: context)

	    if self.modelObjectID != nil {

		 	if let _baseStat = json["baseStat"].int {
		 		self.baseStat = _baseStat
            }

		 	if let _effort = json["effort"].int {
		 		self.effort = _effort
            }
        }
    }
}