//
//  StatsGraphViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 5/5/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit


class StatsGraphViewController: UIViewController, JBBarChartViewDelegate, JBBarChartViewDataSource {
    
    @IBOutlet weak var weightPushed: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bodyP: UILabel!
    
    var bp : BodyPart!
    var statBP = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (bp.rawValue == "Abs") { statBP = statAbs}
        if (bp.rawValue == "Chest") { statBP = statChest}
        if (bp.rawValue == "Legs") { statBP = statLegs}
        if (bp.rawValue == "Back") { statBP = statBack}
        if (bp.rawValue == "Shoulders") { statBP = statShoulders}
        if (bp.rawValue == "Arms") { statBP = statArms}
        if (bp.rawValue == "None") { statBP = statOther}
        if (bp.rawValue == "Cardio") { statBP = statCardio}
        if (bp.rawValue == "Calories") { statBP = statCalories}
        
        let barChartView = JBBarChartView()
        barChartView.dataSource = self
        barChartView.delegate = self
        barChartView.backgroundColor = UIColor.clearColor()
        barChartView.frame = CGRectMake(10, 10, self.view.bounds.width - 20, self.view.bounds.height * 0.5)
        
        barChartView.reloadData()
        self.view.addSubview(barChartView)
    }
    
    /* Bar color @ index */
    func barChartView(barChartView: JBBarChartView, colorForBarViewAtIndex index: UInt) -> UIColor {
        return (Int(index) % 2 == 0 ) ? UIColor(red: 80/255, green: 95/255, blue: 205/255, alpha: 0.5) : UIColor(red: 100/255, green: 115/255, blue: 215/255, alpha: 0.5);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(statBP.count) //number of lines in chart
    }
    
    func barChartView(barChartView: JBBarChartView, heightForBarViewAtIndex index: UInt) -> CGFloat {
        println("barChartView", index);
        return CGFloat(statBP[Int(index)] as! Int)
    }
    
    func barChartView(barChartView: JBBarChartView, didSelectBarAtIndex index: UInt, touchPoint:CGPoint) {
                date.text = "\(statBP[Int(index)]) lbs"
    }
}