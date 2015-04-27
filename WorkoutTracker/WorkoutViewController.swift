//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var workoutNameLabel: UIButton!
    
    @IBOutlet weak var addExerciseButton: UIButton!
    @IBOutlet weak var notesTextArea: UITextField!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var oldWorkout: UIPickerView!
    var workout : WorkoutObject?
    var oldEx : ExerciseObject = listOfExercises[0] as! ExerciseObject

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
        if ( segue.identifier == "oldExSegue" ) {
            var exerciseView = segue.destinationViewController as! ExerciseViewController
            exerciseView.exercise = oldEx.newCopy()
            workout!.exercises.append(exerciseView.exercise!)
        }
        if ( segue.identifier == "finishedSegue" ) {
            finishedVC = segue.destinationViewController as! FinishedViewController
            finishedVC.workout = workout
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.timeStyle = .ShortStyle
            workout!.setEndTime(formatter.stringFromDate(date))
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (component == 1) {
            return listOfExercises.count
        } else {
            return 1
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (component == 1) {
            let ex = listOfExercises[row] as! ExerciseObject
            return ex.getName()
        } else {
            return "Use Past Exercise:"
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        oldEx = (listOfExercises[row] as! ExerciseObject)
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        if (component == 1) {
            let pickerLabel = UILabel()
            let ex = listOfExercises[row] as! ExerciseObject
            let titleData = ex.getName()
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            pickerLabel.attributedText = myTitle
            return pickerLabel
        } else {
            let pickerLabel = UILabel()
            let titleData = "Use Past Exercise:"
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            pickerLabel.attributedText = myTitle
            return pickerLabel
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.oldWorkout.dataSource = self
        self.oldWorkout.delegate = self
        self.workoutName.delegate = self
        self.notesTextArea.delegate = self
        
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if ( textField == workoutName ) {
            workoutName.resignFirstResponder()
            changeName()
            return true
        } else {
            self.navigationController?.navigationBarHidden = false
            notesTextArea.resignFirstResponder()
            workout!.setNotes(notesTextArea.text)
            return true
        }
    }
}

