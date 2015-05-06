//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //lower buttons
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var workoutButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    //top buttons
    @IBOutlet weak var startNew: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    //body part buttons
    @IBOutlet weak var absButton: UIButton!
    @IBOutlet weak var chestButton: UIButton!
    @IBOutlet weak var legsButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shouldersButton: UIButton!
    @IBOutlet weak var armsButton: UIButton!
    
    //cardio stuff
    @IBOutlet weak var cardioButton: UIButton!
    @IBOutlet weak var caloriesText: UILabel!
    @IBOutlet weak var cardioText: UILabel!
    
    weak var workoutView: WorkoutViewController!

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "newWorkoutSegue" ) {
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
        
        if ( segue.identifier == "oldWorkoutSegue" ) {
            createNewWorkout = false
            
            workoutView = segue.destinationViewController as! WorkoutViewController
            //start new workout with no initial name
            let workout = selectedWorkout.newCopy()
            
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
        
        if testHuh == 0 {
            addTestStuff()
            testHuh = 1
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.hidesBarsWhenKeyboardAppears = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 80/255, green: 95/255, blue: 205/255, alpha: 0.5)
        
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
        
        startNew.layer.borderWidth = 1.0
        startNew.layer.borderColor = UIColor.lightGrayColor().CGColor
        startNew.layer.cornerRadius = 10.0
        startNew.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(startNew)
        
        helpButton.addTarget(self, action: "helpAlert", forControlEvents: UIControlEvents.TouchUpInside)

        //no work images set
        if ( weekAbs == 0 ) { absButton.setImage(noAbs, forState: UIControlState.Normal) }
        if ( weekChest == 0 ) { chestButton.setImage(noChest, forState: UIControlState.Normal) }
        if ( weekLegs == 0 ) { legsButton.setImage(noLegs, forState: UIControlState.Normal) }
        if ( weekBack == 0 ) { backButton.setImage(noBack, forState: UIControlState.Normal) }
        if ( weekShoulders == 0 ) { shouldersButton.setImage(noShoulders, forState: UIControlState.Normal) }
        if ( weekArms == 0 ) { armsButton.setImage(noArms, forState: UIControlState.Normal) }
        
        //good work images set (if it was worked out but not as good as the previous week)
        if ( weekAbs <= preWeekAbs && weekAbs != 0) { absButton.setImage(goodAbs, forState: UIControlState.Normal) }
        if ( weekChest <= preWeekChest && weekChest != 0 ) { chestButton.setImage(goodChest, forState: UIControlState.Normal) }
        if ( weekLegs <= preWeekLegs && weekLegs != 0 ) { legsButton.setImage(goodLegs, forState: UIControlState.Normal) }
        if ( weekBack <= preWeekBack && weekBack != 0 ) { backButton.setImage(goodBack, forState: UIControlState.Normal) }
        if ( weekShoulders <= preWeekShoulders && weekShoulders != 0 ) { shouldersButton.setImage(goodShoulders, forState: UIControlState.Normal) }
        if ( weekArms <= preWeekArms && weekArms != 0 ) { armsButton.setImage(goodArms, forState: UIControlState.Normal) }

        //great work images set (if it was worked out and was better than previous week)
        if ( weekAbs > preWeekAbs ) { absButton.setImage(greatAbs, forState: UIControlState.Normal) }
        if ( weekChest > preWeekChest ) { chestButton.setImage(greatChest, forState: UIControlState.Normal) }
        if ( weekLegs > preWeekLegs ) { legsButton.setImage(greatLegs, forState: UIControlState.Normal) }
        if ( weekBack > preWeekBack ) { backButton.setImage(greatBack, forState: UIControlState.Normal) }
        if ( weekShoulders > preWeekShoulders ) { shouldersButton.setImage(greatShoulders, forState: UIControlState.Normal) }
        if ( weekArms > preWeekArms ) { armsButton.setImage(greatArms, forState: UIControlState.Normal) }
        
        caloriesText.text = String(weekCalories)
        
        if ( weekCardio > 0 ) {
        cardioText.text = String(weekCardio/60) + " H " + String(weekCardio % 60) + " M"
        } else {
            cardioText.text = "0"
        }
        
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
    
    func helpAlert() {
        
        var imageView = UIImageView(frame: CGRectMake(70, 25, 15, 15))
        imageView.image = UIImage(named: "Full Moon-50 copy.png")
        var imageView2 = UIImageView(frame: CGRectMake(70, 42, 15, 15))
        imageView2.image = UIImage(named: "Full Moon-50 copy 2.png")
        var imageView3 = UIImageView(frame: CGRectMake(70, 59, 15, 15))
        imageView3.image = UIImage(named: "Full Moon-50.png")
        
        let alertController = UIAlertController(title: "", message:
            "Great Workout \nGood Workout \nNo Workout", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.view.addSubview(imageView)
        alertController.view.addSubview(imageView2)
        alertController.view.addSubview(imageView3)


        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

