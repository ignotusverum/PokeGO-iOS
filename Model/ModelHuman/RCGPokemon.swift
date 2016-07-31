
//
//  RCGPokemon.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

import MagicalRecord

@objc(RCGPokemon)
public class RCGPokemon: _RCGPokemon {
    
    static let pokemonImages: [UIImage] = UIImage.imagesWithSpriteSheet()

    // Images
    class func imageForID(pokemonID: Int)-> UIImage? {
        
        let pokemons = RCGPokemon.pokemonImages
        
        if pokemons.count < pokemonID {
         
            return RCGPokemon.pokemonImages[pokemonID - 1]
        }
        
        return nil
    }
    
	// MARK: - Fetching logic
	class func fetchObjectWithID(objectID: Int, context: NSManagedObjectContext) throws -> RCGPokemon? {

        return try RCGPokemon.modelFetchWithID(objectID, context:context) as? RCGPokemon
    }

    class func fetchOrInsertWithJSON(json: JSON, context: NSManagedObjectContext = NSManagedObjectContext.MR_defaultContext()) throws -> RCGPokemon? {

        return try RCGPokemon.modelFetchOrInsertWithJSON(json, context: context) as? RCGPokemon
    }
    
    class func fetchOrInsertWithJSON(json: JSON) throws -> RCGPokemon? {
        
        return try RCGPokemon.modelFetchOrInsertDefaultWithJSON(json) as? RCGPokemon
    }

    // MARK: - Parsing JSON
    override func setValueWithJSON(json: JSON, context: NSManagedObjectContext) {

	    super.setValueWithJSON(json, context: context)

        if let _height = json["height"].float {
            self.height = _height
        }

        if let _name = json["name"].string {
            self.name = _name
        }
        
        if let _weight = json["weight"].float {
            self.weight = _weight
        }
        
        if let abilitiesJSONArray = json["abilities"].array {
            for ability in abilitiesJSONArray {
                
                if ability["ability"] != nil {
                    let abilityJSON = ability["ability"]
                    
                    do {
                        
                        let abilityObject = try RCGPokekonAbilities.fetchOrInsertWithJSON(abilityJSON, context: context)
                        
                        if let abilityObject = abilityObject {
                            if !self.abilities.containsObject(abilityObject) {
                                self.addAbilitiesObject(abilityObject)
                                abilityObject.pokemon = self
                            }
                        }
                    }
                    catch { }
                }
            }
        }
        
        if let movesJSONArray = json["moves"].array {
            for move in movesJSONArray {
                
                if move["move"] != nil {
                    let moveJSON = move["move"]
                    
                    do {
                        
                        let moveObject = try RCGPokemonMove.fetchOrInsertWithJSON(moveJSON, context: context)
                        
                        if let moveObject = moveObject {
                            if !self.moves.containsObject(moveObject) {
                                self.addMovesObject(moveObject)
                                moveObject.pokemon = self
                            }
                        }
                    }
                    catch { }
                }
            }
        }
        
        if let typesJSONArray = json["types"].array {
            for type in typesJSONArray {
                
                if type["type"] != nil {
                    let typeJSON = type["type"]
                    
                    do {
                        
                        let typeObject = try RCGPokemonType.fetchOrInsertWithJSON(typeJSON, context: context)
                        
                        if let typeObject = typeObject {
                            if !self.types.containsObject(typeObject) {
                                self.addTypesObject(typeObject)
                                typeObject.addPokemonObject(self)
                            }
                        }
                    }
                    catch { }
                }
            }
        }
    }
}