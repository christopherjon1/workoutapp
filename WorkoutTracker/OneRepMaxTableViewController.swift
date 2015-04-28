//
//  oneRepMaxTableViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/27/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class OneRepMaxTableViewController: UITableViewController {
    
    weak var workout : WorkoutObject!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return workout.exercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("oneRepCell") as! UITableViewCell
        //exercise at index path
        cell.textLabel!.text = workout.exercises[indexPath.row].getName() + " " + String(stringInterpolationSegment: workout.exercises[indexPath.row].getOneRepMax()) + " lbs"
        return cell
    }
}