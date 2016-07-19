//
//  RCGPokemon.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

import MagicalRecord

@objc(RCGPokemon)
public class RCGPokemon: _RCGPokemon {

	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext) throws -> RCGPokemon? {

        return try RCGPokemon.modelFetchWithID(objectID, context:context) as? RCGPokemon
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> RCGPokemon? {

        return try RCGPokemon.modelFetchOrInsertWithJSON(json, context: context) as? RCGPokemon
    }
    
    class func fetchOrInsertWithJSON(json: JSON) throws -> RCGPokemon? {
        
        return try RCGPokemon.modelFetchOrInsertDefaultWithJSON(json) as? RCGPokemon
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, context: NSManagedObjectContext) {

	    super.setValueWithJSON(json, context: context)

        if let _height = json["height"].float {
            self.height = _height
        }

        if let _name = json["name"].string {
            self.name = _name
        }

        if let _weight = json["weight"].float {
            self.weight = _weight
        }
        
        if let abilitiesJSONArray = json["abilities"].array {
            for ability in abilitiesJSONArray {
                
                if ability["ability"] != nil {
                    let abilityJSON = ability["ability"]
                    
                    do {
                        
                        let abilityObject = try RCGPokekonAbilities.fetchOrInsertWithJSON(abilityJSON, context: context)
                        
                        if !self.abilities.containsObject(abilityObject!) {
                            self.addAbilitiesObject(abilityObject!)
                            abilityObject?.pokemon = self
                        }
                    }
                    catch { }
                }
                
            }
        }
    }
}