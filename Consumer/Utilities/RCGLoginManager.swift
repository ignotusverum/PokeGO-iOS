//
//  RCGLoginManager.swift
//  Consumer
//
//  Created by Vladislav Zagorodnyuk on 7/22/16.
//  Copyright © 2016 Vlad Z. All rights reserved.
//

import PromiseKit

import SwiftyJSON

class RCGLoginManager: RCGNetworkingManager {

    static let PTC_LOGIN_URL = "https://sso.pokemon.com/sso/login?service=https%3A%2F%2Fsso.pokemon.com%2Fsso%2Foauth2.0%2FcallbackAuthorize"
    static let PTC_LOGIN_OAUTH = "https://sso.pokemon.com/sso/oauth2.0/accessToken"
    static let PTC_LOGIN_CLIENT_SECRET = "w8ScCUXJQc6kXKw8FiOhd8Fixzht18Dq3PEVkUCP5ZPxtgyWsbTvWHFLm2wNY0JR"
    
    class func promiseLoginWithUserName(userName: String?, password: String?)-> Promise<String?> {
        
        return Promise { fulfill, reject in
         
            guard let userName = userName, let password = password else {
                
                fulfill(nil)
                return
            }
            
         
            self.firstPhaseUserName(userName, password: password).then { params in
                return self.secondPhaseWithParameters(params)
                }.then { params2 in
                    return self.thirtPhaseWithParameters(params2)
                }.then { result-> Void in
                    print(result)
            }
        }
    }
    
    class func firstPhaseUserName(userName: String, password: String)-> Promise<[String: AnyObject]> {
        
        let netman = RCGNetworkingManager.sharedManager
        
        return Promise { fulfill, reject in
         
            netman.GET(RCGLoginManager.PTC_LOGIN_URL, parameters: nil, encoding: .URL).then { result-> Void in
                
                if let lt = result["lt"].string, let execution = result["execution"].string {
                    
                    let loginParameters = ["lt": lt, "execution": execution, "_eventId": "submit", "username": userName, "password": password]
                
                    fulfill(loginParameters)
                }
                }.error { error in
                    reject(error)
            }
        }
    }
    
    class func secondPhaseWithParameters(parameters: [String: AnyObject])-> Promise<[String: AnyObject]> {
        
        let netman = RCGNetworkingManager.sharedManager
        
        let url = NSURL(string: RCGLoginManager.PTC_LOGIN_URL)
        
            return Promise { fulfill, reject in
                netman.manager.request(.POST, url!, parameters: parameters, encoding: .URL, headers: nil)
                    .validate()
                    .responseJSON { response in
                
                        print("----")
                        print(response.response?.URL?.URLString)
                        
                        guard let response = response.response, let range = response.URL!.URLString.rangeOfString(".*ticket=", options: .RegularExpressionSearch)
                            else {
                                let error = NSError.cancelledError()
                                reject(error)
                                return
                        }
                        
                        let ticket = response.URL!.URLString.substringFromIndex(range.endIndex)
                        
                            let params = [ "client_id": "mobile-app_pokemon-go", "redirect_uri": "https://www.nianticlabs.com/pokemongo/error", "client_secret": RCGLoginManager.PTC_LOGIN_CLIENT_SECRET, "grant_type": "refresh_token", "code": ticket ]
                        
                        fulfill(params)
                }
        }
    }
    
    class func thirtPhaseWithParameters(parameters: [String: AnyObject])-> Promise<String> {
        
        let netman = RCGNetworkingManager.sharedManager
        
        return Promise { fulfill, reject in
            
            netman.POST(RCGLoginManager.PTC_LOGIN_OAUTH, parameters: parameters, encoding: .URL).then { result-> Void in
                
                
            }
        }
    }
}
