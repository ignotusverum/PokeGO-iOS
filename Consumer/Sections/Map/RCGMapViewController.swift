//
//  RCGMapViewController.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 7/26/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import UIKit

import MapKit

class RCGMapViewController: UIViewController {

    //
    var region: MKCoordinateRegion?
    
    //
    var radar: CLLocationCoordinate2D?
    
    //
    @IBOutlet var locationButton: UIButton!
    
    @IBOutlet var mapView: MKMapView!
    
    //
    var locationManager: CLLocationManager?
    
    var mapLocatoin: [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RCGPokemonAdapter.fetchPokemonList().then { resultArray in
            print(resultArray)
        }
    }
}
