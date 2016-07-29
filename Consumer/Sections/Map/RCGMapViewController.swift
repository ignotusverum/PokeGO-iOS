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
    
    @IBOutlet var radarButton: UIButton!
    
    @IBOutlet var mapView: MKMapView!
    
    //
    var locationManager: CLLocationManager?
    
    var requestStr: String?
    
    var display_pokemons_str: String?
    
    var display_pokestops_str: String?
    
    var timerData: NSTimer?
    var timerDataCleaner: NSTimer?
    
    var pokemons = [AnyObject]()
    var pokestops = [AnyObject]()
    var gyms = [AnyObject]()
    
    var mapLocatoin: [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://localhost:5000/raw_data?pokemon=true&pokestops=true&gyms=true"
        
        let netman = RCGNetworkingManager.sharedManager
        netman.GET(urlString, parameters: nil).then { result in
            print(result)
        }
    }
}
