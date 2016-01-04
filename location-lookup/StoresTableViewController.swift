//
//  StoresTableViewController.swift
//  location-lookup
//
//  Created by Tyler Bobella on 1/2/16.
//  Copyright © 2016 tjb. All rights reserved.
//

import UIKit
import CoreLocation
import PromiseKit
import SwiftyJSON


class StoresTableViewController: UITableViewController, CLLocationManagerDelegate {
    var tableViewCellCount: Int = 0
    var json: JSON = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 75.0
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:", name:"load", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    /*
    **
    ** !! TABLE VIEW METHODS !!
    **
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("storeCell") as UITableViewCell!
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        if let businesses = appDelegate.locationDH.json["businesses"].array {
            if let storeName = cell.viewWithTag(1) as? UILabel {
                storeName.text = businesses[indexPath.row]["name"].string
            }
            
            if let milesAway = cell.viewWithTag(2) as? UILabel {
                let dDistance = businesses[indexPath.row]["distance"].double! * 0.00062137
                let stringValue = String(format: "%.02f miles away", dDistance)
                milesAway.text = stringValue
            }
            
            if let storeType = cell.viewWithTag(3) as? UILabel {
                let categories = businesses[indexPath.row]["categories"].array
                storeType.text = categories?.first![0].string
            }
            
            if let isClosed = cell.viewWithTag(4) as? UILabel {
                if businesses[indexPath.row]["is_closed"] {
                    isClosed.text = "Closed"
                    isClosed.textColor = UIColor.grayColor()
                } else {
                    isClosed.text = "Open"
                    isClosed.textColor = UIColor.greenColor()
                }
            }
            
            // TODO: Implement image 
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let total = appDelegate.locationDH.json["businesses"].array {
            count = total.count
        }
        return count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }

}
