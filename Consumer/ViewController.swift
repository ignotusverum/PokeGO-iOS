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
    }
}

