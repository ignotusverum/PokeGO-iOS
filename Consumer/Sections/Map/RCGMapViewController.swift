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
        
        self.mapView.delegate = self
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
    
    func startMapFetcher() {
        
        let mapFetcher = RCGMapFetcher.sharedFetcher
        
        mapFetcher.delegate = self
        mapFetcher.startFetching()
    }
}

// MARK: - Map Fetcher Delegate
extension RCGMapViewController: RCGMapFetcherDelegate {
    
    func fetchedPokemons(pokemons: [RCGPokemonMap]) {
    
        // Notify or do something
    }
}

// MARK: - Fetch result controller
extension RCGMapViewController: NSFetchedResultsControllerDelegate {
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        // Get object
        let pokemon = anObject as? RCGPokemonMap
        
        // Create pokemon annotation
        let annotation = RCGPokemonAnnotation(pokemonMap: pokemon)
        
        switch type {
        case .Delete:
            
            if !self.pokemonRemoveAnnotations.contains(annotation) {
                self.pokemonRemoveAnnotations.append(annotation)
            }
            
        case .Insert:
            
            if !self.pokemonAddAnnotations.contains(annotation) {
                self.pokemonAddAnnotations.append(annotation)
            }
            
        case .Update:
            
            print("handle update")
            
        default:
            break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {

        // Main thread to update map
        dispatch_async(dispatch_get_main_queue()) {
            // Cleaning stuff
            self.mapView.removeAnnotations(self.pokemonRemoveAnnotations)
            self.mapView.addAnnotations(self.pokemonAddAnnotations)
            
            self.mapView.zoomToFitAnnotations(self.pokemonAddAnnotations, userLocation: nil)
        }
    }
}

// MARK: - Location Manager Delegate
extension RCGMapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        // Set user location
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        self.userLocation = center
    }
}

// MARK: - Map View Delegate
extension RCGMapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let userLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800.0, 800.0)
        self.mapView.setRegion(userLocation, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        var pinView: RCGAnnotationView?
        // Checking if annotation != current user
        if !annotation.isKindOfClass(MKUserLocation) {
            
            let pinIdentifier = "RCGPokemonIdentifier"
            pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(pinIdentifier) as? RCGAnnotationView
            
            if pinView == nil {
                // Using pokemon annotation
                if let annotation = annotation as? RCGPokemonAnnotation {
                    pinView = RCGAnnotationView(pokemonAnnotation: annotation, reuseIdentifier: pinIdentifier)
                }
            }
        }
        
        return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let pokemonAnnotationView = view as? RCGAnnotationView {
         
            // TODO: Show pokemon details controller
            print(pokemonAnnotationView.pokemonAnnotation?.pokemonMap?.pokemonID)
        }
    }
}
