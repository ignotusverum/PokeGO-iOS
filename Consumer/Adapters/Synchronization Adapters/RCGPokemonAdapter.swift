//
//  RCGPokemonAdapter.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 7/13/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import PromiseKit

import SwiftyJSON

import CoreData
import MagicalRecord

class RCGPokemonAdapter: RCGSynchronizerAdapter {
    
    // Fetching pokemons
    class func fetchPokemonWithID(pokemonID: Int)-> Promise<RCGPokemon?> {
        return Promise { fulfill, reject in
            
            let netman = RCGNetworkingManager.sharedManager
            
            netman.GET("/pokemon/\(pokemonID)", parameters: nil).then { result-> Void in
    
                var pokemon: RCGPokemon?
                
                do {
                    // Creating pokemon objects in database
                    pokemon = try RCGPokemon.fetchOrInsertWithJSON(result)
                    
                    // Saving
                    try NSManagedObjectContext.MR_defaultContext().save()
                    
                } catch { }
                
                fulfill(pokemon)
            }
        }
    }
    
    class func fetchPokemons()-> Promise<[RCGPokemon]> {
        return Promise { fulfill, reject in
            
            let netman = RCGNetworkingManager.sharedManager
            
            netman.GET("/pokemon", parameters: nil).then { result-> Void in
             
                var resultArray = [RCGPokemon]()
                
                if let resultDict = result["results"].array {
                    
                    // Safety check
                
                    do {
                        // Loopin through json array
                        for (i, object) in resultDict.enumerate() {
                        
                            var jsonUpdate = object
                            // Start from 1
                            jsonUpdate["id"] = JSON(i + 1)
                            
                            // Creating pokemon objects in database
                            let pokemon = try RCGPokemon.fetchOrInsertWithJSON(jsonUpdate)
                            
                            // Safety check if it failes
                            if let pokemon = pokemon {
                                // Building result array
                                resultArray.append(pokemon)
                            }
                        }
                        
                        // Saving
                        try NSManagedObjectContext.MR_defaultContext().save()
                        
                        } catch { }
                        
                    fulfill(resultArray)
                }
            }
        }
    }
}
