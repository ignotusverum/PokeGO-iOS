//
//  RCGStopAdapter.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 8/1/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import SwiftyJSON
import PromiseKit
import MagicalRecord

class RCGStopAdapter: RCGMapAdapter {
    
    // Fetch pokemon for map
    class func fetchStopLocations()-> Promise<[RCGStopMap]?> {
        return Promise { fulfill, reject in
            
            self.fetchMapData(stopEnabled: true).then { resultDict-> Void in
                
                var resultArray = [RCGStopMap]()
                
                // Getting pokemon list
                if let stopsJSONArray = resultDict["pokestops"]?.array {
                    
                    do {
                        // Getting pokemon JSON
                        for stopJSON in stopsJSONArray {
                            
                            let stopMap = try RCGStopMap.fetchOrInsertWithJSON(stopJSON)
                            
                            // Safety check
                            if let stopMap = stopMap {
                                resultArray.append(stopMap)
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
