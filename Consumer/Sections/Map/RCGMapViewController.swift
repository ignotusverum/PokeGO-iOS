//
//  RCGMapViewController.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 7/26/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class RCGMapViewController: UIViewController {

    // Location Manager - current location
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    
    // Current Location Button
    @IBOutlet var locationButton: UIButton!

    // Map View
    @IBOutlet var mapView: MKMapView!
    
    // Annotations
    var pokemonAnnotations = [MKPointAnnotation]()
    
    // MARK: - Controller lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start location manager
        self.startLocationManager()
    }
    
    // MARK: - Utilities
    func startLocationManager() {
        
        // Ask Authorization
        self.locationManager.requestAlwaysAuthorization()
        
        // If enabled
        if CLLocationManager.locationServicesEnabled() {
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
            
            self.mapView.showsUserLocation = true
            
            // Map fetcher start
            self.startMapFetcher()
        }
        else {
            // Show empty view with alert
            print("Locatoin sevices disabled")
        }
    }
    
    func addMapAnnotations(pokemons: [RCGPokemonMap]) {
        
        for pokemon in pokemons {
         
            if let latitude = pokemon.latitude, let longitude = pokemon.longitude {
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                
                // Checking if pin already there
                if !self.pokemonAnnotations.contains(annotation) {
                    
                    self.pokemonAnnotations.append(annotation)
                    // Update map
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
        
        if let userLocation = self.userLocation {
            self.mapView.zoomToFitAnnotations(self.pokemonAnnotations, userLocation: userLocation)
        }
        else {
            
        }
    }
    
    func startMapFetcher() {
        
        let mapFetcher = RCGMapFetcher.sharedFetcher
        
        mapFetcher.delegate = self
        mapFetcher.startFetching()
    }
}

// MARK: - Map Fetcher Delegate
extension RCGMapViewController: RCGMapFetcherDelegate {
    
    func fetchedPokemons(pokemons: [RCGPokemonMap]) {
        
        self.addMapAnnotations(pokemons)
    }
}

// MARK: - Location Manager Delegate
extension RCGMapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        // Set user location
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.userLocation = center
        
        self.mapView.setRegion(region, animated: true)
    }
}

// MARK: - Map View Delegate
extension RCGMapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let userLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800.0, 800.0)
        self.mapView.setRegion(userLocation, animated: true)
    }
}
