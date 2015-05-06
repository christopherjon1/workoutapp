//
//  Model.swift
//  WorkoutTracker
//
//  Created by Christopher Hartley on 4/14/15.
//  Copyright (c) 2015 Christopher Hartley. All rights reserved.
//

import UIKit

var navigationController : UINavigationController = UINavigationController()

//when work out is done, make a copy of the object
//if it is not in this set, add it to this set with empty values.
//when starting an existing workout copy from this set.

var selectedWorkout : WorkoutObject!

//create new
var createNewWorkout = true
var createNewExercise = true

//total reps allowed, total pounds allows
var totalRepAllowed = 50
var totalPoundsAllowed = 1001

//cardio stuff
var totalCardioAllowed = 120
var totalCaloriesAllowed = 2000

//"week" time
var week = 7

//weekly stats
var weekAbs = 0
var weekChest = 0
var weekLegs = 0
var weekBack = 0
var weekShoulders = 0
var weekArms = 0
var weekOther = 0
var weekCardio = 0
var weekCalories = 0

//previous weekly stats
var preWeekAbs = 100
var preWeekChest = 100
var preWeekLegs = 500
var preWeekBack = 1200
var preWeekShoulders = 1020
var preWeekArms = 300
var preWeekOther = 5000
var preWeekCardio = 0
var preWeekCalories = 0

func setWeekPart(bp: BodyPart, toAdd: Int){
    switch bp {
    case .Abs:
        weekAbs += toAdd
    case .Chest:
        weekChest += toAdd
    case .Legs:
        weekLegs += toAdd
    case .Back:
        weekBack += toAdd
    case .Shoulders:
        weekShoulders += toAdd
    case .Arms:
        weekArms += toAdd
    case .Cardio:
        weekCardio += toAdd
    case .Calories:
        weekCalories += toAdd
    case .None:
        weekOther += toAdd
    }
}

func removeWeekPart(bp: BodyPart, toAdd: Int){
    switch bp {
    case .Abs:
        weekAbs -= toAdd
    case .Chest:
        weekChest -= toAdd
    case .Legs:
        weekBack -= toAdd
    case .Back:
        weekBack -= toAdd
    case .Shoulders:
        weekShoulders -= toAdd
    case .Arms:
        weekArms -= toAdd
    case .Cardio:
        weekCardio -= toAdd
    case .Calories:
        weekCalories -= toAdd
    case .None:
        weekOther -= toAdd
    }
}

//other stats, an array of past stats
var statAbs : [Int] = []
var statChest : [Int] = []
var statLegs : [Int] = []
var statBack : [Int] = []
var statShoulders : [Int] = []
var statArms : [Int] = []
var statOther : [Int] = []
var statCardio : [Int] = []
var statCalories : [Int] = []

//a dictionary for completed workouts
var pastWorkouts : NSMutableArray = []
//an array of workouts for showing workouts one can do
var listOfWorkouts : NSMutableArray = []
var listOfExercises : NSMutableArray = []

//Not Worked out Image
let noAbs = UIImage(named: "Torso-50.png")
let noChest = UIImage(named: "Torso-50.png")
let noLegs = UIImage(named: "Leg-501.png")
let noBack = UIImage(named: "Torso-50.png")
let noShoulders = UIImage(named: "Torso-50.png")
let noArms = UIImage(named: "Flex Biceps-50.png")

//Good work out image
let goodAbs = UIImage(named: "Prelum-50.png")
let goodChest = UIImage(named: "Chest-50 (1).png")
let goodLegs = UIImage(named: "Leg-50 (1) copy.png")
let goodBack = UIImage(named: "Back Muscles-50.png")
let goodShoulders = UIImage(named: "Shoulders-50 (1).png")
let goodArms = UIImage(named: "Flex Biceps-50 copy.png")

//Great work out image
let greatAbs = UIImage(named: "Prelum-50 (1).png")
let greatChest = UIImage(named: "Chest-50.png")
let greatLegs = UIImage(named: "Leg-50.png")
let greatBack = UIImage(named: "Back-50.png")
let greatShoulders = UIImage(named: "Shoulders-50.png")
let greatArms = UIImage(named: "Flex Biceps-50 (1).png")

//---------------------------------------Add exercise / Workout ----------------------------------

func addWorkoutToList(_workout: WorkoutObject) -> Bool {
    
    //boolean if i found it if not create new workout
    for w in listOfWorkouts {
        let vv : WorkoutObject = w as! WorkoutObject
        if (vv.getName() == _workout.getName()) {
            createNewWorkout = false
        }
    }
    
    if (createNewWorkout) {
        listOfWorkouts.addObject(_workout.newCopy())
        for e in _workout.exercises {
            addExerciseToList(e)
        }
        return true
    } else {
        createNewWorkout = true
        return false
    }
}

func addExerciseToList(_exercise: ExerciseObject) -> Bool{
    
    //boolean if i found it if not create new workout
    for e in listOfExercises {
        let ex : ExerciseObject = e as! ExerciseObject
        if (ex.getName() == _exercise.getName()) {
            createNewExercise = false
        }
    }
    
    if (createNewExercise) {
        listOfExercises.addObject(_exercise.newCopy())
        return true
    } else {
        createNewExercise = true
        return false
    }
}

//----------------------------------------------test stuff ---------------------------------------

var testHuh = 0

func addTestStuff() {
    //test workout objects.
    var arms : WorkoutObject = WorkoutObject(_name: "Arms")
    var curls : ExerciseObject = ExerciseObject(_name: "Curls")
    var extentions : ExerciseObject = ExerciseObject(_name: "Extentions")
    curls.setBodyPart(.Arms)
    extentions.setBodyPart(.Arms)
    arms.setExercise(curls)
    arms.setExercise(extentions)
    var legs : WorkoutObject = WorkoutObject(_name: "Legs")
    var squat : ExerciseObject = ExerciseObject(_name: "Squats")
    var lunges : ExerciseObject = ExerciseObject(_name: "Lunges")
    legs.setExercise(squat)
    legs.setExercise(lunges)
    
    listOfWorkouts.addObject(arms.newCopy())
    listOfWorkouts.addObject(legs.newCopy())
    listOfExercises.addObject(curls.newCopy())
    listOfExercises.addObject(extentions.newCopy())
    listOfExercises.addObject(squat.newCopy())
    listOfExercises.addObject(lunges.newCopy())
    
    //test workout objects.
    var chest : WorkoutObject = WorkoutObject(_name: "Chest")
    var bench : ExerciseObject = ExerciseObject(_name: "Bench")
    var press : ExerciseObject = ExerciseObject(_name: "Dumbell Press")
    var dips : ExerciseObject = ExerciseObject(_name: "Dips")
    bench.setBodyPart(.Chest)
    press.setBodyPart(.Chest)
        dips.setBodyPart(.Chest)
    chest.setExercise(bench)
    chest.setExercise(press)
    chest.setExercise(dips)
    var abs : WorkoutObject = WorkoutObject(_name: "Abs")
    var situps : ExerciseObject = ExerciseObject(_name: "Sit ups")
    abs.setExercise(situps)
    
    listOfWorkouts.addObject(chest.newCopy())
    listOfWorkouts.addObject(abs.newCopy())
    listOfExercises.addObject(bench.newCopy())
    listOfExercises.addObject(press.newCopy())
    listOfExercises.addObject(dips.newCopy())
    listOfExercises.addObject(situps.newCopy())
    
    var currentDateTime = NSDate()
    var lastWeek = currentDateTime.subtractDays(7)
    legs.setDate(lastWeek)
    legs.setStartTime("9:50")
    legs.setEndTime("10:30")
    legs.setNotes("Great Workout")
    squat.setOneRepMax(100)
    squat.setReps(30)
    var s : SetObject = SetObject()
    s.setReps(10)
    s.setWeight(100)
    squat.sets = [s, s, s]
    lunges.setOneRepMax(80)
    lunges.setReps(29)
    lunges.sets = [s, s, s]
    legs.exercises.append(squat)
    lastWeek = currentDateTime.subtractDays(6)
    arms.setDate(lastWeek)
    arms.setStartTime("8:43")
    arms.setEndTime("11:30")
    arms.setNotes("Such a long one")
    curls.setOneRepMax(60)
    curls.setReps(50)
    curls.sets = [s, s, s]
    extentions.setOneRepMax(75)
    extentions.setReps(40)
    extentions.sets = [s, s, s]
    lastWeek = currentDateTime.subtractDays(5)
    chest.setDate(lastWeek)
    chest.setStartTime("9:00")
    chest.setEndTime("10:11")
    chest.setNotes("Ugh...")
    bench.setOneRepMax(120)
    bench.setReps(15)
    bench.sets = [s, s, s]
    press.setOneRepMax(95)
    press.setReps(32)
    press.sets = [s, s, s]
    dips.setOneRepMax(0)
    dips.setReps(100)
    dips.sets = [s, s, s]
    lastWeek = currentDateTime.subtractDays(4)
    abs.setDate(lastWeek)
    abs.setStartTime("6:28")
    abs.setEndTime("7:16")
    situps.setOneRepMax(100)
    situps.setReps(30)
    situps.sets = [s, s, s]
    pastWorkouts.addObject(legs)
    pastWorkouts.addObject(arms)
    pastWorkouts.addObject(chest)
    pastWorkouts.addObject(abs)
    
    statAbs  = [0,1000,1100,1200,1150,1200,1312]
    statChest  = [0,1021,900,800,790,820,850]
    statLegs  = [0,1021,1900,1800,1790,1820,1850]
    statBack  = [0,2100,2210,1800,1710,2220,1850]
     statShoulders  = [0,2101,2260,1200,1530,2250,1230]
     statArms  = [0,2121,2262,1222,1532,2252,1232]
     statOther  = [0,2105,2260,5200,5530,2250,5230]
}

//----------------------------------------------Objects-------------------------------------------

//workout object
class WorkoutObject: NSObject, NSCoding {
    private var name : String
    var exercises : [ExerciseObject] = []
    private var notes : String = ""
    private var date : NSDate!
    private var startTime : String = ""
    private var endTime : String = ""
    private var totalWeight : Int = 0
    
    @objc required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        exercises = aDecoder.decodeObjectForKey("exercises") as! [ExerciseObject]
        notes = aDecoder.decodeObjectForKey("notes") as! String
        date = aDecoder.decodeObjectForKey("date") as? NSDate
        startTime = aDecoder.decodeObjectForKey("startTime") as! String
        endTime = aDecoder.decodeObjectForKey("endTime") as! String
        totalWeight = aDecoder.decodeIntegerForKey("totalWeight")
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(exercises, forKey: "exercises")
        aCoder.encodeObject(notes, forKey: "notes")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(startTime, forKey: "startTime")
        aCoder.encodeObject(endTime, forKey: "endTime")
        aCoder.encodeInteger(totalWeight, forKey: "totalWeight")
    }
    
    @objc init(_name : String) {
        name = _name
    }
    func getName() -> String {
        return name
    }
    func setName(_name: String) {
        name = _name
    }
    func getExercises ()-> [ExerciseObject] {
        return exercises
    }
    func getExerciseAt(index : Int) -> ExerciseObject {
        return exercises[index]
    }
    func setExercise(exercise: ExerciseObject) {
        exercises.append(exercise)
    }
    func setNotes(_notes : String) {
        notes = _notes
    }
    func getNotes() -> String {
        return notes
    }
    func setDate(_date : NSDate) {
        date = _date
    }
    func getDate() -> NSDate {
        return date
    }
    func getDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        return formatter.stringFromDate(date)
    }
    func setStartTime(_time : String) {
        startTime = _time
    }
    func getStartTime() -> String {
        return startTime
    }
    func setEndTime(_time : String) {
        endTime = _time
    }
    func getEndTime() -> String {
        return endTime
    }
    func newCopy() -> WorkoutObject {
        var newW : WorkoutObject = WorkoutObject(_name: name)
        for (var i = 0 ; i < exercises.count; i++) {
            var e : ExerciseObject = exercises[i]
            newW.exercises.append(e.newCopy())
        }
        return newW
    }
    func addToTotalWeight(weight: Int) {
        totalWeight += weight
    }
    func removeFromTotalWeight(weight: Int) {
        totalWeight -= weight
    }
    func getTotalWeight() -> Int {
        for e in exercises {
            totalWeight += e.getWeightPushed()
        }
        return totalWeight
    }
    func getTotalSets() -> Int {
        var tsets = 0
        for e in exercises {
            tsets += e.sets.count
        }
        return tsets
    }
    func getTotalReps() -> Int {
        var treps = 0
        for e in exercises {
            for s in e.sets {
                treps += s.getReps()
            }
        }
        return treps
    }
}

class SetObject: NSObject, NSCoding  {
    private var reps : Int = 0
    private var weight : Int = 0
    private var string = ""
    
    override init() {}
    
    @objc required init(coder aDecoder: NSCoder) {
        reps = aDecoder.decodeIntegerForKey("reps")
        weight = aDecoder.decodeIntegerForKey("weight")
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(reps, forKey: "reps")
        aCoder.encodeInteger(weight, forKey: "weight")
    }
    
    func setReps(_reps: Int) {
        reps = _reps
    }
    func getReps() -> Int {
        return reps
    }
    func setWeight(_weight: Int) {
        weight = _weight
    }
    func getWeight() -> Int {
        return weight
    }
    func getString() -> String {
        return String(reps) + " reps with " + String(weight) + " lbs"
    }
}

//exercise object
class ExerciseObject: NSObject, NSCoding  {
    
    private var name : String
    private var bodyPart : BodyPart = .None
    var sets : [SetObject] = []
    private var weightPushed = 0
    private var totalReps = 0
    private var oneRepMax = 0
    
    @objc required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        bodyPart = BodyPart(rawValue: (aDecoder.decodeObjectForKey("bodyPart") as! String))!
        sets = aDecoder.decodeObjectForKey("sets") as! [SetObject]
        weightPushed = aDecoder.decodeIntegerForKey("weightPushed")
        totalReps = aDecoder.decodeIntegerForKey("totalReps")
        oneRepMax = aDecoder.decodeIntegerForKey("oneRepMax")
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(bodyPart.rawValue, forKey: "bodyPart")
        aCoder.encodeObject(sets, forKey: "sets")
        aCoder.encodeInteger(weightPushed, forKey: "weightPushed")
        aCoder.encodeInteger(totalReps, forKey: "totalReps")
        aCoder.encodeInteger(oneRepMax, forKey: "oneRepMax")
    }
    
    init(_name : String) {
        name = _name
    }
    
    func getBodyPart() -> BodyPart {
        return bodyPart
    }
    func setBodyPart(_bodyPart: BodyPart) {
        bodyPart = _bodyPart
    }
    func getOneRepMax() -> Int {
        let a = 37 - self.getReps()
        let b : Double = 36 / Double(a)
        if (totalReps == 0 ) {return 0}
        let c : Double = Double(weightPushed / totalReps)
        let d : Double = 1.0 + (0.025 * Double(totalReps))
        return Int(c * d)
    }
    func setOneRepMax(_oneRepMax: Int) {
        oneRepMax = _oneRepMax
    }
    func getName() -> String {
        return name
    }
    func setName(_name: String) {
        name = _name
    }
    func getReps() -> Int {
        totalReps = 0
        for s in sets {
            totalReps += s.getReps()
        }
        return totalReps
    }
    func setReps(_reps: Int) {
        totalReps = _reps
    }
    func getWeightPushed() -> Int {
        for s in sets {
            weightPushed += s.getWeight() * s.getReps()
        }
        return weightPushed
    }
    func setWeightPushed(_weightPushed: Int) {
        weightPushed = _weightPushed
    }
    func newCopy() -> ExerciseObject {
        var newEx : ExerciseObject = ExerciseObject(_name: name)
        newEx.bodyPart = bodyPart
        return newEx
    }
}

//-------------------------------------Enum Body Part Stuff---------------------------------------------------

//enum of body parts that could be used
enum BodyPart : String {
    case Abs = "Abs"
    case Chest = "Chest"
    case Legs = "Legs"
    case Back = "Back"
    case Shoulders = "Shoulders"
    case Arms = "Arms"
    case None = "None"
    case Cardio = "Cardio"
    case Calories = "Calories"
    
    static var count: Int { return BodyPart.None.hashValue + 1}
}

func getIndexOfBodyPart(Index: BodyPart) -> Int {
    
    switch Index {
    case .Abs:
        return 1
    case .Chest:
        return 2
    case .Legs:
        return 3
    case .Back:
        return 4
    case .Shoulders:
        return 5
    case .Arms:
        return 6
    case .Cardio:
        return 7
    case .Calories:
        return 8
    case .None:
        return 0
    }
}

func getValueOfBodyPartAtIndex(Index: Int) -> BodyPart {
    
    switch Index {
    case 1:
        return .Abs
    case 2:
        return .Chest
    case 3:
        return .Legs
    case 4:
        return .Back
    case 5:
        return .Shoulders
    case 6:
        return .Arms
    case 7:
        return .Cardio
    case 8:
        return .Calories
    default:
        return .None
    }
}

func getValueOfBodyPartAtIndex(Index: Int) -> String {
    
    var value = ""
    
    switch Index {
    case 1:
        value = "Abs"
    case 2:
        value = "Chest"
    case 3:
        value = "Legs"
    case 4:
        value = "Back"
    case 5:
        value = "Shoulders"
    case 6:
        value = "Arms"
    case 7:
        value = "Cardio"
    case 8:
        value = "Calories"
    default:
        value = "None"
    }
    
    return value
}

//------------------------------------------date stuff-----------------------------------

extension NSDate
{
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    
    //    func isEqualToDate(dateToCompare : NSDate) -> Bool
    //    {
    //        //Declare Variables
    //        var isEqualTo = false
    //
    //        //Compare Values
    //        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
    //        {
    //            isEqualTo = true
    //        }
    //
    //        //Return Result
    //        return isEqualTo
    //    }
    
    
    
    func addDays(daysToAdd : Int) -> NSDate
    {
        var secondsInDays : NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        var dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func subtractDays(daysToSubtract : Int) -> NSDate
    {
        var secondsInDays : NSTimeInterval = Double(daysToSubtract) * 24 * 60 * 60
        var dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(-secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    
    func addHours(hoursToAdd : Int) -> NSDate
    {
        var secondsInHours : NSTimeInterval = Double(hoursToAdd) * 60 * 60
        var dateWithHoursAdded : NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
