//
//  RCGPokemonMapAdapter.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 8/1/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import PromiseKit
import SwiftyJSON

import MagicalRecord

class RCGPokemonMapAdapter: RCGMapAdapter {

    // Fetch pokemon for map
    class func fetchPokemonLocations()-> Promise<[RCGPokemonMap]?> {
        return Promise { fulfill, reject in
            
            self.fetchMapData(true).then { resultDict-> Void in
                
                var resultArray = [RCGPokemonMap]()
                
                // Getting pokemon list
                if let pokemonJSONArray = resultDict["pokemons"]?.array {
                    
                    do {
                        // Getting pokemon JSON
                        for pokemonJSON in pokemonJSONArray {
                            
                            let pokemonMap = try RCGPokemonMap.fetchOrInsertWithJSON(pokemonJSON)
                            
                            // Safety check
                            if let pokemonMap = pokemonMap {
                                resultArray.append(pokemonMap)
                            }
                        }
                        
                        // Clean database
                        self.removeOldPokemons(resultArray)
                        
                        // Save to database
                        try NSManagedObjectContext.MR_defaultContext().save()
                    }
                    
                    fulfill(resultArray)
                }
            }
        }
    }
    
    class func removeOldPokemons(pokemons: [RCGPokemonMap]) {
        
        // Can contain nils
        let spawnPointIDs = pokemons.flatMap { $0.spawnpointID }
        
        // Fetching pokemons with spawnPointID that's norfrrfrt in server response
        let predicateForSpawnPoint = NSPredicate(format: "NOT (%K IN %@)", RCGPokemonMapAttributes.spawnpointID.rawValue, spawnPointIDs)
        
        // Fetching pokemons that < current date
        let predicateForPast = NSPredicate(format: "(%K < %@)", RCGPokemonMapAttributes.disappearsDate.rawValue, NSDate())
        
        let combinePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateForSpawnPoint, predicateForPast])
        
        // Delete old pokemons
        RCGPokemonMap.MR_deleteAllMatchingPredicate(combinePredicate)
    }
}
