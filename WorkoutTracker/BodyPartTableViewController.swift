//
//  ExerciseTableViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/17/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class BodyPartTableViewController: UITableViewController {
    
    weak var exercise : ExerciseObject!
    var selectedIndex = 0
    var bodyPartToSend : BodyPart!
    weak var graphView: StatsGraphViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "toGraphSegue" ) {
            if let destination = segue.destinationViewController as? StatsGraphViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    bodyPartToSend = getValueOfBodyPartAtIndex(index) as BodyPart
                    destination.bp = bodyPartToSend
                }
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return 7
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("bodyPartsCell") as! UITableViewCell
        //exercise at index path
        cell.textLabel?.text = getValueOfBodyPartAtIndex(indexPath.row)
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
    }
}