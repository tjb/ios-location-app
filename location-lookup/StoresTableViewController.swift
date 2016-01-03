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
            cell.textLabel?.text = businesses[indexPath.row]["name"].string
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
