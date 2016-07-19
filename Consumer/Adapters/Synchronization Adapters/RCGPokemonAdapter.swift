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
                
                var resultArray = [RCGPokemon]()
                
                print(result)
                
                if let resultDict = result["results"].array {
                    
                    print(resultDict)
                    
                    // Safety check
                    
                    do {
                        // Loopin through json array
                        for i in 0..<resultDict.count {
                            
                            var jsonUpdate = resultDict[i]
                            jsonUpdate["id"] = JSON(i)
                            
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
                    
                    fulfill(nil)
                }
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
                        for i in 0..<resultDict.count {
                        
                            var jsonUpdate = resultDict[i]
                            jsonUpdate["id"] = JSON(i)
                            
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
