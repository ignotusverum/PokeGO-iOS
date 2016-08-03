//
//  RCGMapAdapter.swift
//  Consumer
//
//  Created by Vlad Zagorodnyuk on 8/1/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import PromiseKit
import SwiftyJSON

class RCGMapAdapter: RCGSynchronizerAdapter {

    // Fetch pokemon for map
    class func fetchMapData(pokemonEnabled: Bool = false, gymEnabled: Bool = false, stopEnabled: Bool = false)-> Promise<[String: JSON]> {
        return Promise { fulfill, reject in
            
            let netman = RCGNetworkingManager.sharedManager
            
            var parameters = [String: AnyObject]()
            
            parameters["gyms_display"] = gymEnabled
            parameters["pokestops_display"] = stopEnabled
            parameters["pokemon_display"] = pokemonEnabled
            
            let path = "http://localhost:5000/raw_data"
            
            print("Hello")
            print(parameters)
            
            netman.GET(path, parameters: parameters).then { result-> Void in
                
                print(result)
                
                // Checking for json in array / keys (pokemon/stops/gyms)
                if let jsonArray = result.dictionary {
                    
                    fulfill(jsonArray)
                }
                else {
                    print("ERROR: RCGMapAdapter")
                }
                
                }.error { error-> Void in
                    reject(error)
            }
        }
    }
}
