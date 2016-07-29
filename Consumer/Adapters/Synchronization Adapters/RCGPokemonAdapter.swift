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

    // Fetch pokemon for map
    class func fetchPokemonList(pokemonEnabled: Bool = true, gymEnabled: Bool = true, stopEnabled: Bool = true)-> Promise<[RCGPokemonMap]?> {
        return Promise { fulfill, reject in
            
            let netman = RCGNetworkingManager.sharedManager
            
            var parameters = [String: AnyObject]()
            
            parameters["gyms"] = gymEnabled
            parameters["pokestops"] = stopEnabled
            parameters["pokemon"] = pokemonEnabled
            
            let path = "http://localhost:5000/raw_data"
            
            netman.GET(path, parameters: parameters).then { result-> Void in
                
                var resultArray = [RCGPokemonMap]()
                
                // Checking for json in array / keys (pokemon/stops/gyms)
                if let jsonArray = result.dictionary {
                    
                    // Getting pokemon list
                    if let pokemonJSONArray = jsonArray["pokemons"]?.array {
                        
                        // Getting pokemon JSON
                        for pokemonJSON in pokemonJSONArray {
                        
                            do {
                                
                                let pokemon = try RCGPokemonMap.fetchOrInsertWithJSON(pokemonJSON)
                                
                                if let pokemon = pokemon {
                                    resultArray.append(pokemon)
                                }
                            }
                        }
                        
                        // Save
                        try NSManagedObjectContext.MR_defaultContext().save()
                        
                        fulfill(resultArray)
                    }
                }
            }
        }
    }
    
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
