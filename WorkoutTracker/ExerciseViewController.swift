//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var exerciseNameLabel: UIButton!
    
    @IBOutlet weak var addSetButton: UIButton!
    
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    weak var time : NSTimer!
    var counter = 0
    var startPauseStop = 0
    
    var reps = 1
    var pounds = 0
    
    @IBOutlet weak var bodyPartLabel: UIPickerView!
    //    @IBOutlet weak var bodyPartLabel: UILabel!
    @IBOutlet weak var repPounds: UIPickerView!
    
    var exercise : ExerciseObject?
    var bodyPartTable : BodyPartTableViewController!
    var repTable : RepsTableViewController!
    var poundTable : PoundsTableViewController!
    var setTable : SetTableViewController!
    
    weak var exerciseTable: ExerciseTableViewController!
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        if (pickerView == self.bodyPartLabel){
            return 2
        } else {
            return 4
        }
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (pickerView == self.bodyPartLabel){
            if (component == 1) {
                return BodyPart.count
            } else {
                return 1
            }
        } else {
            if (component == 0) {
                return totalRepAllowed
            } else if (component == 1) {
                return 1
            } else if (component == 2) {
                return totalPoundsAllowed
            } else {
                return 1
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerView == self.bodyPartLabel){
            if (component == 1) {
                return getValueOfBodyPartAtIndex(row)
            } else {
                return "Select Body Part"
            }
        } else {
            if (component == 0) {
                return String( row + 1 )
            } else if (component == 1) {
                return "Reps"
            } else if (component == 2) {
                return String( row )
            } else {
                return "Lbs"
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (pickerView == self.bodyPartLabel){
            if (component == 1) {
                exercise!.setBodyPart( getValueOfBodyPartAtIndex( row ) )
            }
        } else {
            if (component == 0) {
                reps = row + 1
            } else if (component == 2) {
                pounds = row
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        if (pickerView == self.bodyPartLabel){
            if (component == 1) {
                let pickerLabel = UILabel()
                let titleData = getValueOfBodyPartAtIndex(row) as String
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            } else {
                let pickerLabel = UILabel()
                let titleData = "Select Body Part"
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            }
        } else {
            if (component == 0) {
                let pickerLabel = UILabel()
                let titleData = String(row + 1)
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            } else if (component == 1) {
                let pickerLabel = UILabel()
                let titleData = "Reps"
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            } else if (component == 2) {
                let pickerLabel = UILabel()
                let titleData = String(row)
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            } else {
                let pickerLabel = UILabel()
                let titleData = "Lbs"
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "setSegue" ) {
            setTable = segue.destinationViewController as! SetTableViewController
            setTable.exercise = exercise!
        }
    }
    
    override func viewWillDisappear(animated: Bool) {

        if (exercise!.getName() == "" ) {
            exercise!.setName("No Name")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = exercise!.getName()
        
        self.bodyPartLabel.dataSource = self
        self.bodyPartLabel.delegate = self
        self.bodyPartLabel.selectRow(getIndexOfBodyPart(exercise!.getBodyPart()), inComponent: 1, animated: false)
        
        self.repPounds.dataSource = self
        self.repPounds.delegate = self
        
        timeButton.addTarget(self, action: "startCounter", forControlEvents: UIControlEvents.TouchUpInside)
        exerciseNameLabel.addTarget(self, action: "changeName", forControlEvents: UIControlEvents.TouchUpInside)
        addSetButton.addTarget(self, action: "addSet", forControlEvents: UIControlEvents.TouchUpInside)
        
        //style for buttons
        exerciseNameLabel.layer.borderWidth = 0.5
        exerciseNameLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        exerciseNameLabel.layer.cornerRadius = 10.0
        exerciseNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(exerciseNameLabel)
        addSetButton.layer.borderWidth = 0.5
        addSetButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        addSetButton.layer.cornerRadius = 10.0
        addSetButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(addSetButton)
    }
    
    func addSet() {
        var set :SetObject = SetObject()
        set.setReps(reps)
        set.setWeight(pounds)
        setWeekPart(exercise!.getBodyPart(), reps * pounds)
        exercise!.sets.append(set)

        self.setTable.tableView.reloadData()
    }
    
    func changeName() {
            
            let alertController = UIAlertController(title: nil, message: "Please enter your exercise name", preferredStyle: .Alert)
            //        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
            
            alertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.text = ""
            })
            
            let declineAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) -> Void in
                self.navigationController?.navigationBarHidden = false
            }
            let acceptAction = UIAlertAction(title: "Ok", style: .Default) { (_) -> Void in
                let textField = alertController.textFields![0] as! UITextField
                
                //boolean if i found it if not create new workout
                for e in listOfExercises {
                    let ex : ExerciseObject = e as! ExerciseObject
                    if (ex.getName() == textField.text) {
                        self.exercise = ex.newCopy()
                        self.setTable.exercise = self.exercise
                        createNewExercise = false
                        break
                    }
                }
                
                if (createNewExercise) {
                    self.exercise!.setName(textField.text)
                    listOfExercises.addObject(self.exercise!.newCopy())
                } else {
                    createNewExercise = true
                }
                
                self.navigationController?.navigationBarHidden = false

                //set the title to the workout name
                self.title = self.exercise!.getName()
                self.viewDidLoad()
                
//                self.bodyPartLabel.reloadAllComponents()
            
                self.exercise!.setName(textField.text)
            }
            alertController.addAction(declineAction)
            alertController.addAction(acceptAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        
//        exercise!.setName(exerciseName.text)
//        self.title = exercise!.getName()
//        exerciseName.text = ""
//        exerciseName.resignFirstResponder()
//        self.navigationController?.navigationBarHidden = false
    }
    
    func updateCounter() {
        var min = String(format: "%02d", (Int(counter/60)) )
        var sec = String(format: "%02d", (counter++ % 60))
        timeText.text = min + " : " + sec
    }
    
    //When the button is pushed it is either counting, paused or cleared
    //Why? becuase the user shouldn't need to pause then restart. This
    //way the functionallity makes it easier for the user.
    func startCounter() {
        switch startPauseStop {
        case 0:
            updateCounter()
            time = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        case 1:
            time.invalidate()
        default:
            counter = 0
            timeText.text = "00 : 00"
        }
        
        if ( startPauseStop < 2) { startPauseStop++ }
        else { startPauseStop = 0 }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
}

