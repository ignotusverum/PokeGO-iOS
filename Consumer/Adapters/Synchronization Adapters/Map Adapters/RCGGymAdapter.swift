//
//  RCGGymAdapter.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 8/1/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import PromiseKit
import SwiftyJSON

import MagicalRecord

class RCGGymAdapter: RCGMapAdapter {

    // Fetch pokemon for map
    class func fetchGymLocations()-> Promise<[RCGGymMap]?> {
        return Promise { fulfill, reject in
            
            self.fetchMapData(true).then { resultDict-> Void in
                
                var resultArray = [RCGGymMap]()
                
                // Getting pokemon list
                if let gymsJSONArray = resultDict["gyms"]?.array {
                    
                    do {
                        // Getting pokemon JSON
                        for gymJSON in gymsJSONArray {
                            
                            let gymMap = try RCGGymMap.fetchOrInsertWithJSON(gymJSON)
                            
                            // Safety check
                            if let gymMap = gymMap {
                                resultArray.append(gymMap)
                            }
                        }
                        
                        // Save to database
                        try NSManagedObjectContext.MR_defaultContext().save()
                    }
                    
                    fulfill(resultArray)
                }
            }
        }
    }
}
