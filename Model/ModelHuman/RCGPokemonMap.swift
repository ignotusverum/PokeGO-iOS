//
//  RCGPokemonMap.swift
//  consumer
//
//  Created by Vladislav Zagorodnyuk on 2/3/16.
//  Copyright Â© 2016 Red Circle Games. All rights reserved.
//

import CoreData
import SwiftyJSON

import CoreLocation

public class RCGPokemonMap: NSObject {

    // PokemonID
    var pokemonID: Int?
    
    // Name
    var name: String?
    
    // Flag to show, if not dissapeared
    var avaliable = false
    
    // Location
    var location: CLLocationCoordinate2D? {
        get {
            
            // Safety check
            guard let latitude = self.latitude, let longitude = self.longitude else {
                
                return nil
            }
            
            return CLLocationCoordinate2DMake(latitude, longitude)
        }
    }
    
    // Dissapear Time
    var dissapearDate: NSDate? {
        didSet {
            // Safety check
            guard let dissapearDate = dissapearDate else {
                return
            }
    
            let currentDate = NSDate()
            
            if currentDate < dissapearDate {
                // In the present
                self.avaliable = false
            }
            else {
                // In the future
                self.avaliable = true
            }
        }
    }
    
    var dissapearTime: Int? {
        didSet {
            
            // Safety check
            guard let dissapearTime = dissapearTime else {
                return
            }
            
            // Milli / 1000 = sec
            let timeInSec: NSTimeInterval = Double(dissapearTime / 1000)
            
            // Date
            let dateFromTime = NSDate(timeIntervalSince1970: timeInSec)
            
            self.dissapearDate = dateFromTime
        }
    }
    
    // Encounter ID
    var encounterID: String?
    
    // Latitude
    var latitude: Double?
    
    // Longitude
    var longitude: Double?
    
    // Spawnpoint ID
    var spawnpointID: Int?
    
    // MARK: - Parsing JSON
    init(json: JSON) {

        if let _modelObjetID = json["pokemon_id"].int {
            
            self.pokemonID = _modelObjetID
            
            if let _name = json["pokemon_name"].string {
                
                self.name = _name
            }
            
            if let _disappearTime = json["disappear_time"].int {
                self.dissapearTime = _disappearTime
            }
            
            if let _encounterID = json["encounter_id"].string {
                self.encounterID = _encounterID
            }
            
            if let _latitude = json["latitude"].double {
                self.latitude = _latitude
            }
            
            if let _longitude = json["longitude"].double {
                self.longitude = _longitude
            }
            
            if let _spawnpointID = json["spawnpointID"].int {
                self.spawnpointID = _spawnpointID
            }
        }
    }
}