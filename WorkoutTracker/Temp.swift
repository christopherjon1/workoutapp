//
//  ViewController.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit
//
//class ExerciseViewController: UIViewController {
//    
//    @IBOutlet weak var startButton: UIButton!
//    @IBOutlet weak var workoutButton: UIButton!
//    @IBOutlet weak var statsButton: UIButton!
//    @IBOutlet weak var settingsButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        startButton.layer.borderWidth = 0.5
//        startButton.layer.borderColor = UIColor.lightGrayColor().CGColor
//        startButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        view.addSubview(startButton)
//        workoutButton.layer.borderWidth = 0.5
//        workoutButton.layer.borderColor = UIColor.lightGrayColor().CGColor
//        workoutButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        view.addSubview(workoutButton)
//        statsButton.layer.borderWidth = 0.5
//        statsButton.layer.borderColor = UIColor.lightGrayColor().CGColor
//        statsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        view.addSubview(statsButton)
//        settingsButton.layer.borderWidth = 0.5
//        settingsButton.layer.borderColor = UIColor.lightGrayColor().CGColor
//        settingsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//        view.addSubview(settingsButton)
//        
//
//        let views: [String: UIView] = ["start": startButton, "work": workoutButton, "stats": statsButton, "setting": settingsButton]
//        
//        
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[start][work(start)][stats(start)][setting(start)]|", options: .allZeros, metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[start]|", options: .allZeros, metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[work]|", options: .allZeros, metrics: nil, views: views))
//        
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[stats]|", options: .allZeros, metrics: nil, views: views))
//        
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[setting]|", options: .allZeros, metrics: nil, views: views))
//        
//        
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func supportedInterfaceOrientations() -> Int {
//        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
//    }
//    
//    func helpAlert() {
//        
//        var imageView = UIImageView(frame: CGRectMake(70, 20, 15, 15))
//        imageView.image = UIImage(named: "Full Moon-50 copy.png")
//        var imageView2 = UIImageView(frame: CGRectMake(70, 37, 15, 15))
//        imageView2.image = UIImage(named: "Full Moon-50 copy 2.png")
//        var imageView3 = UIImageView(frame: CGRectMake(70, 54, 15, 15))
//        imageView3.image = UIImage(named: "Full Moon-50.png")
//        
//        let alertController = UIAlertController(title: "", message:
//            "Great Workout \nGood Workout \nNo Workout", preferredStyle: UIAlertControllerStyle.Alert)
//        alertController.view.addSubview(imageView)
//        alertController.view.addSubview(imageView2)
//        alertController.view.addSubview(imageView3)
//        
//        
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }
//    
//    func showAlert() {
//        
//        let alertController = UIAlertController(title: "Disclaimer", message: "Before using this teaching resource, you confirm that you agree:\n1. To obey the law regarding data protection and patient confidentiality.\n2. To us this app professionally and appropriately in clinical settings.\n3. This is for your personal use and you may not modify, distribute, publish, transfer any information obtained from this teaching resource without the developers' permission.\n4. In no event shall the developer be liable to you for any loss arising from your use of this resource.", preferredStyle: .Alert)
//        
//        let declineAction = UIAlertAction(title: "Decline", style: .Cancel, handler: nil)
//        let acceptAction = UIAlertAction(title: "Accept", style: .Default) { (_) -> Void in
//            
//            self.performSegueWithIdentifier("SomeSegue", sender: self) // Replace SomeSegue with your segue identifier
//        }
//        
//        alertController.addAction(declineAction)
//        alertController.addAction(acceptAction)
//        
//        presentViewController(alertController, animated: true, completion: nil)
//    }
//}

