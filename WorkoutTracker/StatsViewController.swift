//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {//, JBBarChartViewDelegate, JBBarChartViewDataSource  {
    
    //lower buttons
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var workoutButton: UIButton!
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    weak var workoutView: WorkoutViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
//    
//    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
//        println("numberOfBarsInBarChartView");
//        return 10 //number of lines in chart
//    }
//    
//    func barChartView(barChartView: JBBarChartView, heightForBarViewAtIndex index: UInt) -> CGFloat {
//        println("barChartView", index);
//        
//        return CGFloat(arc4random_uniform(100));
//    }
    
    
    
    override func viewDidLoad() {
        
//        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
//        label.center = CGPointMake(160, 284)
//        label.textAlignment = NSTextAlignment.Center
//        label.text = "I'm a test label"
//        self.view.addSubview(label)
//        
//        let barChartView = JBBarChartView();
//        barChartView.dataSource = self;
//        barChartView.delegate = self;
//        barChartView.backgroundColor = UIColor.darkGrayColor();
//        barChartView.frame = CGRectMake(0, 20, 320, 200);
//        barChartView.reloadData();
//        self.view.addSubview(barChartView);
//        println("Launched");
        
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

