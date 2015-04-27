//
//  ExerciseTableViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/17/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class RepsTableViewController: UITableViewController {
    
    var reps = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return totalRepAllowed
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "repsCell")
        //exercise at index path
        cell.textLabel?.text = String(indexPath.row + 1)
        reps = indexPath.row + 1
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        reps = indexPath.row + 1
    }
}

class PoundsTableViewController: UITableViewController {
    
    var pounds = 0
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return totalPoundsAllowed
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "poundsCell")
        //exercise at index path
        cell.textLabel?.text = String(indexPath.row)
        pounds = Int(indexPath.row.value)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        pounds = Int(indexPath.row.value)
    }
}