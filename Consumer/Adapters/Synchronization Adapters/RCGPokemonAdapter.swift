//
//  RCGPokemonAdapter.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 7/13/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import PromiseKit

class RCGPokemonAdapter: RCGSynchronizerAdapter {

    // Fetching pokemons
    class func fetchPokemons()-> Promise<[RCGPokemon]> {
        return Promise { fulfill, reject in
            
            let netman = RCGNetworkingManager.sharedManager
            
            netman.GET("/pokemon", parameters: nil).then { result-> Void in
             
                var resultArray = [RCGPokemon]()
                
                // Safety check
                if let jsonArray = result.array {
                
                    // Loopin through json array
                    for json in jsonArray {
                        do {
                            // Creating pokemon objects in database
                            let pokemon = try RCGPokemon.fetchOrInsertWithJSON(json)
                            
                            // Safety check if it failes
                            if let pokemon = pokemon {
                                // Building result array
                                resultArray.append(pokemon)
                            }
                            
                            // Create error handling
                        } catch { }
                        
                        fulfill(resultArray)
                    }
                }
            }
        }
    }
}
