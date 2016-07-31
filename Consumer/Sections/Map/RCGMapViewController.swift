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

import CoreData

class RCGMapViewController: UIViewController {

    // Location Manager - current location
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    
    // Current Location Button
    @IBOutlet var locationButton: UIButton!

    // Map View
    @IBOutlet var mapView: MKMapView!
    
    // Annotations
    var pokemonAddAnnotations = [RCGPokemonAnnotation]()
    var pokemonRemoveAnnotations = [RCGPokemonAnnotation]()
    
    // Fetch Controller
    var pokemonFetchController = NSFetchedResultsController()
    
    // MARK: - Controller lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start location manager
        self.startLocationManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createPokemonFetcher()
    }
    
    // MARK: - Fetch
    func createPokemonFetcher() {
        
        self.pokemonFetchController = RCGPokemonMap.MR_fetchAllSortedBy(RCGModelAttributes.modelObjectID.rawValue, ascending: true, withPredicate: nil, groupBy: nil, delegate: self)
        self.pokemonFetchController.delegate = self
        
        do {
            
            try self.pokemonFetchController.performFetch()
        }
        catch {
            
            print("fetchingt error")
        }
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
        
        self.pokemonAddAnnotations = [RCGPokemonAnnotation]()
        self.pokemonRemoveAnnotations = [RCGPokemonAnnotation]()
        
        for pokemon in pokemons {
            
            let annotation = RCGPokemonAnnotation(pokemonMap: pokemon)
            
            // Checking if pin already there && not dissapeared
            if !self.pokemonAddAnnotations.contains(annotation) && pokemon.avaliable {
                
                self.pokemonAddAnnotations.append(annotation)
            }
                // If dissapeared, remove from the map
            else if !pokemon.avaliable {
                
                self.pokemonAddAnnotations.append(annotation)
            }
        }
        
        // Update map with pokemons
        self.mapView.addAnnotations(self.pokemonAddAnnotations)
        self.mapView.removeAnnotations(self.pokemonAddAnnotations)
        
//        // Zoom to fit
//        self.mapView.zoomToFitAnnotations(self.pokemonAnnotations, userLocation: userLocation)
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

// MARK: - Fetch result controller
extension RCGMapViewController: NSFetchedResultsControllerDelegate {
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Delete:
            print("delete")
        case .Insert:
            print("insert")
        case .Update:
            print("update")
        default:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {

        
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
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        var pinView: MKAnnotationView?
        // Checking if annotation != current user
        if !annotation.isKindOfClass(MKUserLocation) {
            
            let pinIdentifier = "RCGPokemonIdentifier"
            pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(pinIdentifier)
            
            if pinView == nil {
             
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
                pinView?.canShowCallout = true
                
                let pokemonAnnotation = annotation as! RCGPokemonAnnotation
                
                pinView?.image = RCGPokemon.imageForID(pokemonAnnotation.pokemonMap!.modelObjectID!.integerValue)
            }
        }
        
        return pinView
    }
}
