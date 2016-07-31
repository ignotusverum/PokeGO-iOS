//
//  RCGPokemonAnnotation.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/31/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import MapKit

class RCGPokemonAnnotation: MKPointAnnotation {

    // Pokemon
    var pokemonMap: RCGPokemonMap?
    
    // Custom initialization
    init(pokemonMap: RCGPokemonMap?) {
        
        super.init()
        
        // Safety check
        guard let pokemonMap = pokemonMap else {
            return
        }
        
        if let location = pokemonMap.location {
            
            self.coordinate = location
        }
        
        self.title = pokemonMap.name
        
        self.subtitle = String(pokemonMap.dissapearDate)
    }
}
