//
//  RCGConsumerConfig.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/30/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

protocol RCGMapFetcherDelegate {
    func fetchedPokemons(pokemons: [RCGPokemonMap])
}

class RCGMapFetcher: NSObject {

    // Shared Manager
    static let sharedFetcher = RCGMapFetcher()
    
    // Delegate
    var delegate: RCGMapFetcherDelegate?
    
    // Global Timer
    var fetcherTimer:NSTimer?
    
    func startFetching() {
        
        self.fetcherTimer?.invalidate()
        self.fetcherTimer = nil
        
        self.fetcherTimer = NSTimer(timeInterval: 5.0, target: self, selector: #selector(RCGMapFetcher.fetchData), userInfo: nil, repeats: true)
    }
    
    func fetchData() {

        RCGPokemonAdapter.fetchPokemonLocations().then { resultArray-> Void in
            
            if let resultPokemons = resultArray {
                self.delegate?.fetchedPokemons(resultPokemons)
            }
        }
    }
}
