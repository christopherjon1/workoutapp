//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class PastWorkoutViewController: UIViewController {
    
    //lower buttons
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var workoutButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    weak var workoutView: WorkoutViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "createNewWorkoutSegue" ) {
            createNewWorkout = true
            
            workoutView = segue.destinationViewController as! WorkoutViewController
            //start new workout with no initial name
            let workout = WorkoutObject(_name: "No Name");
            //set start time
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.timeStyle = .ShortStyle
            workout.setStartTime(formatter.stringFromDate(date))
            
            //set date
            let date2 = NSDate()
            let formatter2 = NSDateFormatter()
            formatter2.dateStyle = .ShortStyle
            workout.setDate(date2)
            
            workoutView.workout = workout;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.hidesBarsWhenKeyboardAppears = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        startButton.layer.borderWidth = 0.5
        startButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        startButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(startButton)
        workoutButton.layer.borderWidth = 0.5
        workoutButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        workoutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(workoutButton)
        statsButton.layer.borderWidth = 0.5
        statsButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        statsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(statsButton)
        settingsButton.layer.borderWidth = 0.5
        settingsButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        settingsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(settingsButton)
        
        let views: [String: UIView] = ["start": startButton, "work": workoutButton, "stats": statsButton, "setting": settingsButton]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[start][work(start)][stats(start)][setting(start)]|", options: .allZeros, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[start]|", options: .allZeros, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[work]|", options: .allZeros, metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[stats]|", options: .allZeros, metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[setting]|", options: .allZeros, metrics: nil, views: views))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
}

class PastWorkoutTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.clearColor()
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //this should be the amount of exercises in the workout
        return pastWorkouts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("pastWorkoutCell") as! UITableViewCell
        //exercise at index path
        let w = pastWorkouts[pastWorkouts.count - 1 - indexPath.row] as! WorkoutObject
        cell.textLabel!.text = w.getName()
        return cell
    }
}
