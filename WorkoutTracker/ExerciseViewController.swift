//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var exerciseName: UITextField!
    @IBOutlet weak var exerciseNameLabel: UIButton!
    
    
    @IBOutlet weak var addSetButton: UIButton!
    
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    weak var time : NSTimer!
    var counter = 0
    var startPauseStop = 0
    
    @IBOutlet weak var bodyPartLabel: UIPickerView!
    //    @IBOutlet weak var bodyPartLabel: UILabel!
    
    var exercise : ExerciseObject?
    var bodyPartTable : BodyPartTableViewController!
    var repTable : RepsTableViewController!
    var poundTable : PoundsTableViewController!
    var setTable : SetTableViewController!
    
    weak var exerciseTable: ExerciseTableViewController!
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 2
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (component == 1) {
            return BodyPart.count
        } else {
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (component == 1) {
            return getValueOfBodyPartAtIndex(row)
        } else {
            return "Select Body Part"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (component == 1) {
            exercise!.setBodyPart( getValueOfBodyPartAtIndex( row ) )
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "bodyPartSegue" ) {
            bodyPartTable = segue.destinationViewController as! BodyPartTableViewController
            bodyPartTable.exercise = exercise
        }
        if ( segue.identifier == "poundsSegue" ) {
            poundTable = segue.destinationViewController as! PoundsTableViewController
        }
        if ( segue.identifier == "repsSegue" ) {
            repTable = segue.destinationViewController as! RepsTableViewController
        }
        if ( segue.identifier == "setSegue" ) {
            setTable = segue.destinationViewController as! SetTableViewController
            setTable.exercise = exercise!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = exercise!.getName()
        
        self.bodyPartLabel.dataSource = self
        self.bodyPartLabel.delegate = self
        self.bodyPartLabel.selectRow(getIndexOfBodyPart(exercise!.getBodyPart()), inComponent: 1, animated: false)
        
        exerciseName.borderStyle = UITextBorderStyle.RoundedRect
        
        timeButton.addTarget(self, action: "startCounter", forControlEvents: UIControlEvents.TouchUpInside)
        exerciseNameLabel.addTarget(self, action: "changeName", forControlEvents: UIControlEvents.TouchUpInside)
        addSetButton.addTarget(self, action: "addSet", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func addSet() {
        var set :SetObject = SetObject()
        set.setReps(repTable.reps)
        set.setWeight(poundTable.pounds)
        exercise!.sets.append(set)
        setTable.tableView.reloadData()
    }
    
    func changeName() {
        exercise!.setName(exerciseName.text)
        self.title = exercise!.getName()
        exerciseName.text = ""
        exerciseName.resignFirstResponder()
        self.navigationController?.navigationBarHidden = false
    }
    
    func setBodyPart() {
        //        bodyPartLabel.text = getValueOfBodyPartAtIndex( bodyPartTable.selectedIndex )
        exercise!.setBodyPart(getValueOfBodyPartAtIndex( bodyPartTable.selectedIndex ))
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

