//
//  ViewController.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/12/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

import PokemonKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RCGPokemonAdapter.fetchPokemons().then { result in
            print(result)
        }
        
        
//        PokemonKit.fetchBerryList()
//            .then { berryList in
//                print(berryList)
//            }.error { error in
//                print(error)
//        }
//
//        PokemonKit.fetchPokemon("1").then { result in
//            print(result.name)
//        }
        
//        PokemonKit.fetchPokemons().then { list in
//            
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }
}

