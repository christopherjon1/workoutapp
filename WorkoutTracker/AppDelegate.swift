//
//  AppDelegate.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/6/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        addTestStuff()
        testHuh = 1
        
        var paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        var basePath : NSString = paths.objectAtIndex(0) as! NSString
        var temp : NSMutableArray? = NSKeyedUnarchiver.unarchiveObjectWithFile(String(basePath) + "work.dat") as! NSMutableArray?
        if ( temp != nil ) {
            pastWorkouts = temp!
            
            
            //Get Current Date/Time
            var currentDateTime = NSDate()
            
            for p in pastWorkouts {
                var pastW = p as! WorkoutObject
                addWorkoutToList(pastW)
                
                for e in pastW.exercises {
                    addExerciseToList(e)
                }
                
                //get the workout data from the last week and then the week before
                
                //                println( pastW.getDate().isGreaterThanDate( currentDateTime.subtractDays(7) ) )
                if ( pastW.getDate().isGreaterThanDate( currentDateTime.subtractDays(week) ) ) {
                    for ex in pastW.exercises {
                        var exer = ex as ExerciseObject
                        if ( exer.getBodyPart() == .Abs) { weekAbs += exer.getWeightPushed() }
                        if ( exer.getBodyPart() == .Chest) { weekChest += exer.getWeightPushed() }
                        if ( exer.getBodyPart() == .Legs) { weekLegs += exer.getWeightPushed() }
                        if ( exer.getBodyPart() == .Back) { weekBack += exer.getWeightPushed() }
                        if ( exer.getBodyPart() == .Shoulders) { weekShoulders += exer.getWeightPushed() }
                        if ( exer.getBodyPart() == .Arms) { weekArms += exer.getWeightPushed() }
                    }
                }
                else if ( pastW.getDate().isGreaterThanDate( currentDateTime.subtractDays(week*2) ) &&
                    pastW.getDate().isLessThanDate( currentDateTime.subtractDays(week) ) ) {
                        for ex in pastW.exercises {
                            var exer = ex as ExerciseObject
                            if ( exer.getBodyPart() == .Abs) { preWeekAbs += exer.getWeightPushed() }
                            if ( exer.getBodyPart() == .Chest) { preWeekChest += exer.getWeightPushed() }
                            if ( exer.getBodyPart() == .Legs) { preWeekLegs += exer.getWeightPushed() }
                            if ( exer.getBodyPart() == .Back) { preWeekBack += exer.getWeightPushed() }
                            if ( exer.getBodyPart() == .Shoulders) { preWeekShoulders += exer.getWeightPushed() }
                            if ( exer.getBodyPart() == .Arms) { preWeekArms += exer.getWeightPushed() }
                        }
                }
//                for ex in pastW.exercises {
//                    var exer = ex as ExerciseObject
//                    if ( exer.getBodyPart() == .Abs) { preWeekAbs += exer.getWeightPushed() }
//                    if ( exer.getBodyPart() == .Chest) { preWeekChest += exer.getWeightPushed() }
//                    if ( exer.getBodyPart() == .Legs) { preWeekLegs += exer.getWeightPushed() }
//                    if ( exer.getBodyPart() == .Back) { preWeekLegs += exer.getWeightPushed() }
//                    if ( exer.getBodyPart() == .Shoulders) { preWeekShoulders += exer.getWeightPushed() }
//                    if ( exer.getBodyPart() == .Arms) { preWeekArms += exer.getWeightPushed() }
//                }
            }
            
            //Get Reminder Date (which is Due date minus 7 days lets say)
            //            var reminderDate = dueDate.addDays(-7)
            
            //Check if reminderDate is Greater than Right now
            //            if(reminderDate.isGreaterThanDate(currentDateTime))
            //            {
            //            }
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

