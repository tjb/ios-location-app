//
//  YelpService.swift
//  location-lookup
//
//  Created by Tyler Bobella on 1/2/16.
//  Copyright © 2016 tjb. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import SwiftyJSON
import Haneke
import CoreLocation
import OAuthSwift


class YelpService: NSObject {
    let ENV = NSProcessInfo.processInfo().environment
    var oAuthYelp = OAuthSwiftClient(
        consumerKey: "iKrcGndblces9dg-YsHpzg",
        consumerSecret: "fCozgs0e1Z6Fifuh_EUfsb6PD00",
        accessToken: "YmTA9-bnVWOc-NFAejUs03Tw3OQn2u6_",
        accessTokenSecret: "naIgslFT8UnnjQC8BMLVZhqmi3Y"
    )
    
    enum yelpApiError: ErrorType {
        case InvalidYelpUrl
    }
    
    /**
     
     Returns Yelp Promise object based on location input
     
     - Parameter latitude: Latitude of location for query
     - Parameter longitude: Longitude of location for query
     */
    func getYelpByLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Promise<AnyObject> {
        guard let validUrl = ENV["YELP_API_URL"] where ENV["YELP_API_URL"] != nil else {
            return Promise<AnyObject>(error: yelpApiError.InvalidYelpUrl)
        }
        return Promise { fulfill, reject in
            oAuthYelp.get(validUrl, parameters: ["ll": "\(latitude),\(longitude)","term": "food", "radius_filter": 16000, "sort": 1], success: { data, response in
                fulfill(data)
            }, failure: { error in
                print("Failure: \(error)")
                reject(error)
            })
            
        }
    }
    

}
