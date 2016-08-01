//
//  RCGAnnotationView.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/31/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import MapKit

class RCGAnnotationView: MKAnnotationView {

    // Custom annotation
    var pokemonAnnotation: RCGPokemonAnnotation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.customInit()
    }
    
    init(pokemonAnnotation: RCGPokemonAnnotation, reuseIdentifier: String) {
        super.init(annotation: pokemonAnnotation, reuseIdentifier: reuseIdentifier)

        self.pokemonAnnotation = pokemonAnnotation
        
        self.customInit()
    }
    
    // Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.customInit()
    }
    
    // MARK: - Initialization
    func customInit() {

        let button = UIButton(type: .InfoDark)
        button.frame = CGRect(x: 0.0, y: 0.0, w: 30.0, h: 30.0)
        
        self.canShowCallout = true
        self.rightCalloutAccessoryView = button
    }
}
