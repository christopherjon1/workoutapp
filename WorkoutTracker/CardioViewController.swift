//
//  FinishedView.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/25/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class CardioViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cardioTimeInput: UIPickerView!
    @IBOutlet weak var caloriesInput: UIPickerView!
    @IBOutlet weak var finisheButton: UIButton!
    
    var cardioTime = 1
    var caloriesBurn = 1
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "cardioToHomeSegue" ) {
            weekCardio += self.cardioTime
            weekCalories += self.caloriesBurn
        }
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        if (pickerView == self.cardioTimeInput){
            return 3
        }
        return 2
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (pickerView == self.cardioTimeInput){
            if (component == 1) {
                return totalCardioAllowed
            } else {
                return 1
            }
        } else {
            if (component == 1) {
                return totalCaloriesAllowed
            } else {
                return 1
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if (pickerView == self.cardioTimeInput){
            if (component == 1) {
                return 25.0
            }
        }
        return 200
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (pickerView == self.cardioTimeInput){
            if (component == 1) {
                cardioTime = row + 1
            }
        } else {
            if (component == 1) {
                caloriesBurn = row + 1
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        if (pickerView == self.cardioTimeInput){
            if (component == 1) {
                let pickerLabel = UILabel()
                let titleData = String(row + 1)
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            } else if ( component == 2 ) {
                let pickerLabel = UILabel()
                let titleData = "minutes"
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            } else {
                let pickerLabel = UILabel()
                let titleData = "Enter Cardio Time: "
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            }
        } else {
            if (component == 1) {
                let pickerLabel = UILabel()
                let titleData = String(row + 1)
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            } else {
                let pickerLabel = UILabel()
                let titleData = "Enter Calories burned: "
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 14.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
                pickerLabel.attributedText = myTitle
                return pickerLabel
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cardio"
        
        self.cardioTimeInput.dataSource = self
        self.cardioTimeInput.delegate = self
        self.caloriesInput.dataSource = self
        self.caloriesInput.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        finisheButton.layer.borderWidth = 0.5
        finisheButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        finisheButton.layer.cornerRadius = 10.0
        finisheButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(finisheButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
}
