//
//  RCGMapView.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/30/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import MapKit

extension MKMapView {

    func zoomToFitAnnotations(annotations: [MKPointAnnotation], userLocation: CLLocationCoordinate2D?) {
        
        if annotations.count == 0 {
            
            return
        }
        
        let mapEdgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var zoomRect = MKMapRectNull
        
        for index in 0..<annotations.count {
            let annotation = annotations[index]
            let aPoint = MKMapPointForCoordinate(annotation.coordinate)
            let rect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
            
            if MKMapRectIsNull(zoomRect) {
                zoomRect = rect
            }
            else {
                zoomRect = MKMapRectUnion(zoomRect, rect)
            }
        }
        
        // user location check
        if let userLocation = userLocation {
            let aPoint = MKMapPointForCoordinate(userLocation)
            let rect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
            
            if MKMapRectIsNull(zoomRect) {
                zoomRect = rect
            }
            else {
                zoomRect = MKMapRectUnion(zoomRect, rect)
            }
        }
        
        self.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)
    }
}
