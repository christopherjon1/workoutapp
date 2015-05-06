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
    @IBOutlet weak var workoutNameLabel: UIButton!
    
    @IBOutlet weak var addExerciseButton: UIButton!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var oldWorkout: UIPickerView!
    @IBOutlet weak var addNotesButton: UIButton!
    @IBOutlet weak var oldExTabCon: UIView!
    
    var workout : WorkoutObject?
    var oldEx : ExerciseObject? = listOfExercises[0] as? ExerciseObject
    
    weak var exerciseTable: ExerciseTableViewController!
    weak var oldExerciseTable: OldExerciseTableViewController!
    weak var finishedVC: FinishedViewController!
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
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
            
            workout!.exercises.append(exerciseView.exercise!)
        }
        if ( segue.identifier == "oldExSegue" ) {
            var exerciseView = segue.destinationViewController as! ExerciseViewController
            exerciseView.exercise = oldEx!.newCopy()
            workout!.exercises.append(exerciseView.exercise!)
        }
        if ( segue.identifier == "finishedSegue" ) {
            if (workout!.getName() == "" ) {
                workout!.setName("No Name")
            }
            finishedVC = segue.destinationViewController as! FinishedViewController
            finishedVC.workout = workout
            //make sure it isn't in the past workouts
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.timeStyle = .ShortStyle
            workout!.setEndTime(formatter.stringFromDate(date))
            
            pastWorkouts.addObject(workout!)

            var paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
            var basePath : NSString = paths.objectAtIndex(0) as! NSString
            NSKeyedArchiver.archiveRootObject(pastWorkouts, toFile: String(basePath) + "work.dat")
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
        
        //set the title to the workout name
        self.title = workout!.getName()
        
        //sett the date
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        dateText.text = formatter.stringFromDate(date)
        
        workoutNameLabel.addTarget(self, action: "changeName", forControlEvents: UIControlEvents.TouchUpInside)
        addNotesButton.addTarget(self, action: "addNotes", forControlEvents: UIControlEvents.TouchUpInside)
        
        //style for buttons
        workoutNameLabel.layer.borderWidth = 0.5
        workoutNameLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        workoutNameLabel.layer.cornerRadius = 10.0
        workoutNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(workoutNameLabel)
        goButton.layer.borderWidth = 0.5
        goButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        goButton.layer.cornerRadius = 10.0
        goButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(goButton)
        finishButton.layer.borderWidth = 0.5
        finishButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        finishButton.layer.cornerRadius = 10.0
        finishButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(finishButton)
        addNotesButton.layer.borderWidth = 0.5
        addNotesButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        addNotesButton.layer.cornerRadius = 10.0
        addNotesButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(addNotesButton)
    }
    
    func changeName() {
        
        let alertController = UIAlertController(title: nil, message: "Please enter your workout name", preferredStyle: .Alert)
        //        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        
        alertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        
        let declineAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) -> Void in
            self.navigationController?.navigationBarHidden = false
        }
        let acceptAction = UIAlertAction(title: "Ok", style: .Default) { (_) -> Void in
            let textField = alertController.textFields![0] as! UITextField
//            self.workout!.setName(textField.text)
            
            var startTime = self.workout!.getStartTime()
            var date = self.workout!.getDate()
            
            //boolean if i found it if not create new workout
            for w in listOfWorkouts {
                let vv : WorkoutObject = w as! WorkoutObject
                if (vv.getName() == textField.text) {
                    self.workout = vv.newCopy()
                    createNewWorkout = false
                    break
                }
            }
            
            if (createNewWorkout) {
                self.workout = WorkoutObject(_name: textField.text)
                self.workout!.setStartTime(startTime)
                self.workout!.setDate(date)
                listOfWorkouts.addObject(self.workout!.newCopy())
            } else {
                createNewWorkout = true
            }
            
            self.navigationController?.navigationBarHidden = false
            //set the title to the workout name
            self.title = self.workout!.getName()
            self.exerciseTable.workout = self.workout
            self.exerciseTable.tableView.reloadData()
        }
        alertController.addAction(declineAction)
        alertController.addAction(acceptAction)

        presentViewController(alertController, animated: true, completion: nil)
  
    }
    
    func addNotes() {
        
        let alertController = UIAlertController(title: nil, message: "Add Notes", preferredStyle: .Alert)
        //        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        
        alertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = self.workout!.getNotes()
        })
        
        let declineAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) -> Void in
            self.navigationController?.navigationBarHidden = false
        }
        let acceptAction = UIAlertAction(title: "Add Note", style: .Default) { (_) -> Void in
            let textField = alertController.textFields![0] as! UITextField
            self.workout!.setNotes(textField.text)
            self.navigationController?.navigationBarHidden = false
        }
        alertController.addAction(declineAction)
        alertController.addAction(acceptAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

