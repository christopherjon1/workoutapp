//
//  ExerciseTableViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/17/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class WorkoutNamesTableViewController: UITableViewController {
    
    weak var workout : WorkoutObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "toWorkout" ) {
            if let destination = segue.destinationViewController as? WorkoutViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    var work = (listOfWorkouts[index] as! WorkoutObject).newCopy()
                    
                    //set start time
                    let date = NSDate()
                    let formatter = NSDateFormatter()
                    formatter.timeStyle = .ShortStyle
                    work.setStartTime(formatter.stringFromDate(date))
                    
                    //set date
                    let date2 = NSDate()
                    let formatter2 = NSDateFormatter()
                    formatter2.dateStyle = .ShortStyle
                    work.setDate(date2)
                    
                    destination.workout = work
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return listOfWorkouts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("workoutCell") as! UITableViewCell
        //exercise at index path
        var w = listOfWorkouts[indexPath.row] as! WorkoutObject
        cell.textLabel?.text = w.getName()
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedWorkout = listOfWorkouts[indexPath.row] as! WorkoutObject
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
}