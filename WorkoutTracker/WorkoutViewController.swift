//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var workoutNameLabel: UIButton!
    
    @IBOutlet weak var addExerciseButton: UIButton!
    @IBOutlet weak var notesTextArea: UITextView!
    
    var workout : WorkoutObject?
    
    weak var exerciseTable: ExerciseTableViewController!
    weak var oldExerciseTable: OldExerciseTableViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "exerciseSegue" ) {
            exerciseTable = segue.destinationViewController as! ExerciseTableViewController
            exerciseTable.workout = workout
        }
        if ( segue.identifier == "oldExerciseSegue" ) {
            oldExerciseTable = segue.destinationViewController as! OldExerciseTableViewController
            oldExerciseTable.workout = workout
        }
        if ( segue.identifier == "exerciseDetailSegue" ) {
            var exerciseView = segue.destinationViewController as! ExerciseViewController
            var ex :ExerciseObject = ExerciseObject(_name: "")
            exerciseView.exercise = ex
            listOfExercises.addObject(ex)
            workout!.exercises.append(exerciseView.exercise!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set the title to the workout name
        self.title = workout!.getName()
        
        workoutName.borderStyle = UITextBorderStyle.RoundedRect
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        
        dateText.text = formatter.stringFromDate(date)
        
        workoutNameLabel.addTarget(self, action: "changeName", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func changeName() {
        workout!.setName(workoutName.text)
        self.title = workout!.getName()
        workoutName.text = ""
        workoutName.resignFirstResponder()
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
}

