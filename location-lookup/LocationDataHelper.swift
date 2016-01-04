//
//  LocationDataHelper.swift
//  location-lookup
//
//  Created by Tyler Bobella on 1/3/16.
//  Copyright © 2016 tjb. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import PromiseKit
import Foundation

extension Double {
    var mi: Double { return self * 0.00062137 }
}

class LocationDataHelper: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    let yelpApiService = YelpService()
    var json: JSON = []
    
    func loadLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        getYelpData()
    }

    func getYelpData() {
        if locationManager.location != nil {
            when(yelpApiService.getYelpByLocation((locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)).then { data -> Void in
                self.json = JSON(data: data[0] as! NSData)
                for (index,busniess):(String, JSON) in self.json["businesses"] {
                    let convertedDouble = busniess["distance"].double
                    self.json["businesses"][index]["distance"] = JSON((convertedDouble?.mi)!)
                }
                NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            }
        }
    }
}
