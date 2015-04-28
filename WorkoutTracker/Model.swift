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
var totalCaloriesAllowed = 200


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
var preWeekAbs = 10
var preWeekChest = 10
var preWeekLegs = 50
var preWeekBack = 120
var preWeekShoulders = 120
var preWeekArms = 30
var preWeekOther = 50
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
var statCardio : [Int] = []
var statCalories : [Int] = []

//dictionary of workouts
var pastWorkouts : NSMutableDictionary = [:]
var listOfWorkouts : [String] = []
var listOfExercises : [String] = []

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
    
    pastWorkouts.setObject(arms, forKey: arms.getName())
    pastWorkouts.setObject(legs, forKey: legs.getName())
}

//----------------------------------------------Objects-------------------------------------------

//workout object
class WorkoutObject {
    private var name : String
    var exercises : [ExerciseObject] = []
    private var notes : String = ""
    private var date : String = ""
    private var startTime : String = ""
    private var endTime : String = ""
    private var totalWeight = 0
    
    init(_name : String) {
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
    func setDate(_date : String) {
        date = _date
    }
    func getDate() -> String {
        return date
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

class SetObject {
    private var reps = 0
    private var weight = 0
    private var string = ""
    
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
class ExerciseObject {
    
    private var name : String
    private var bodyPart : BodyPart = .None
    var sets : [SetObject] = []
    private var weightPushed = 0
    private var totalReps = 0
    private var oneRepMax = 0
    
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
    func getSets() -> [SetObject] {
        return sets
    }
    func setSets(_sets: [SetObject]) {
        sets = _sets
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
enum BodyPart {
    case Abs
    case Chest
    case Legs
    case Back
    case Shoulders
    case Arms
    case None
    
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
    default:
        value = "None"
    }
    
    return value
}


