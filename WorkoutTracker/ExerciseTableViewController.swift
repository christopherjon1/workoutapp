//
//  ExerciseTableViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/17/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class ExerciseTableViewController: UITableViewController {
    
    weak var workout : WorkoutObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "workToExerciseSegue" ) {
            if let destination = segue.destinationViewController as? ExerciseViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    destination.exercise = workout.getExerciseAt( index )
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return workout.getExercises().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("exerciseCell") as! UITableViewCell
        //exercise at index path
        let ex = workout.getExerciseAt(indexPath.row)
        cell.textLabel?.text = ex.getName()
        cell.separatorInset = UIEdgeInsetsZero
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //create transition to new controller for exercise
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    //this deletes the row
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //line to remove from exercise
            workout.exercises.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
}

class OldExerciseTableViewController: UITableViewController {
    
    weak var workout : WorkoutObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "oldWorkToExerciseSegue" ) {
            if let destination = segue.destinationViewController as? ExerciseViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    var ex = listOfExercises[index] as? ExerciseObject
                    destination.exercise = ex?.newCopy()
                    workout.setExercise((listOfExercises[index] as? ExerciseObject)!)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return listOfExercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("oldExerciseCell") as! UITableViewCell
        //exercise at index path
        let ex = listOfExercises[indexPath.row] as! ExerciseObject
        cell.textLabel?.text = ex.getName()
        cell.separatorInset = UIEdgeInsetsZero
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //create transition to new controller for exercise
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
}

