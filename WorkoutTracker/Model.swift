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

//weekly stats
var weekAbs = 0
var weekChest = 0
var weekLegs = 0
var weekBack = 0
var weekShoulders = 0
var weekArms = 0
var weekCardio = 0
var weekCalories = 0

//previous weekly stats
var preWeekAbs = 0
var preWeekChest = 0
var preWeekLegs = 0
var preWeekBack = 0
var preWeekShoulders = 0
var preWeekArms = 0
var preWeekCardio = 0
var preWeekCalories = 0

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

//workout object
class WorkoutObject {
    private var name : String
    var exercises : [ExerciseObject] = []
    private var notes : String = ""
    private var date : String = ""
    private var startTime : String = ""
    private var endTime : String = ""

    
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
        var new : WorkoutObject = WorkoutObject(_name: name)
        new.exercises = exercises
        return new
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
        return oneRepMax
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
    func getWeightPushed() -> Int {
        return weightPushed
    }
    func setWeightPushed(_weightPushed: Int) {
        weightPushed = _weightPushed
    }
    func newCopy() -> ExerciseObject {
        var new : ExerciseObject = ExerciseObject(_name: name)
        new.bodyPart = bodyPart
        return new
    }
}

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


