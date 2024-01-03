//
//  RandomisedObjectData.swift
//  CoreData Template
//
//  Created by Oscar Hardy on 04/12/2023.
//

import Foundation
import CoreLocation


// TODO: Issue is I won't need most of this, and what performance impact does that bring ?

// MARK: This struct is supposed to be edited and changed, with things commented out etc. When something is added though, it should be added back to the main doc for use elsewhere

// TODO: Maybe small properties and just propertyBetween

// TODO: How to create not so random randomised data? e.g. for weight tracking, how to do the trend? Do func that generally increases/decreased in total or for periods of time, with variations of x each period

struct RandomisedObjectData {
    
    // TODO: Have inputable name then an objectIndexedName
    // e.g Purple / Colour 1
    
    let index: Int
    
    // MARK: Strings
    
    var name: String
    var string: String { objectString() }
    var longString: String { randomLongString() }
    var emptyString: String { "" }
    var stringArray: [String] { randomArray(randomString, 5) }
    var optionalString: String?
    
    // MARK: Numbers
    
    var int: Int { randomInt() }
    var smallInt: Int { randomIntBetween(1, 5) }
    var intArray: [Int] { randomArray( { randomInt(nil) } , 5) }
    var optionalInt: Int? = nil
    
    var double: Double { randomDouble() }
    var smallDouble: Double { randomDoubleBetween(0.0, 5.0) }
    var doubleArray: [Double] { randomArray(randomDouble, 5) }
    var optionalDouble: Double? = nil
    
    var float: Float { randomFloat() }
    var smallFloat: Float { randomFloatBetween(0.0, 5.0) }
    var floatArray: [Float] { randomArray(randomFloat, 5) }
    var optionalFloat: Float? = nil
    
    
    var int64: Int64 { Int64(randomInt()) }
    var smallInt64: Int64 { Int64(smallInt) }
    var int64Array: [Int64] { randomArray({ Int64(randomInt(nil)) }, 5) }
    var optionalInt64: Int64? = nil
    
    // MARK: Coordinates
    
    var coordinates: CLLocationCoordinate2D { randomCoordinates() }
    var longitude: Double { randomLongitude() }
    var latitude: Double { randomLatitude() }
    
    // MARK: Booleans
    
    var bool: Bool { Bool.random() }
    var trueBool: Bool = true
    var falseBool: Bool = false
    var boolArray: [Bool] { randomArray(Bool.random, 5) }
    var optionalBool: Bool? = nil
    
    // MARK: Dates
    
    var date: Date { randomDateBetween() }
    // TODO: Look on BodyWeightTracker
    var indexedDate: Date { Date.daysDif(index * -1) }
    var pastDate: Date { Date.distantPast }
    var futureDate: Date { Date.distantFuture }
    var dateArray: [Date] { randomArray( { randomDateBetween() } , 5) }
    var optionalDate: Date? = nil
    
    // MARK: UUIDs
    
    var uuid: UUID = UUID()
    var uuidArray: [UUID] { randomArray({UUID()}, 5) }
    
    
    // TODO: Need to find some way of including in the index into the calculations
    // - e.g. Date.daysBack(index)
    init(name: String, index: Int) {
        self.name = name
        self.index = index
    }
    
    
}


// TODO: Rename to nilProperty




// TODO: Can have funcs that are more tailored - e.g can change the range, or set coordinates to random but inside London
   

extension RandomisedObjectData {
    
    
    
    // MARK: String
    
    // TODO: This doesn't work..
    // TODO: Need to test & tidy this whole thing
    func randomStringFromDictionary(_ stringType: StringType) -> String {
        
        let finalString: String
        
        if let wordsFilePath = Bundle.main.path(forResource: "web2", ofType: nil) {
            do {
                
                switch stringType {
                case .wordsString:
                    let wordsString = try String(contentsOfFile: wordsFilePath)
                    finalString = wordsString
                case .wordLines:
                    let wordsString = try String(contentsOfFile: wordsFilePath)
                    let wordLines = wordsString.components(separatedBy: .newlines)
                    // TODO: This shouldn't be joined...
                    finalString = wordLines.joined(separator: " --- ")
                case .randomLine:
                    let wordsString = try String(contentsOfFile: wordsFilePath)
                    let wordLines = wordsString.components(separatedBy: .newlines)
                    let randomLine = wordLines[numericCast(arc4random_uniform(numericCast(wordLines.count)))]
                    finalString = randomLine
                }

            } catch { // contentsOfFile throws an error
                print("Error: \(error)")
                finalString = "No string returned from dictionary"
            }
        } else {
            finalString = "Could not find bundle for resource 'web2'"
        }
        
        
        return finalString
        
        
    }
 
    // TODO: Can I find way to store this within the randomStringFromDictionary() ?
    enum StringType {
        case wordsString, wordLines, randomLine
    }
    
    func objectString() -> String {
        "I am a string about \(name), I have lots of interesting information about this thing, like \(int) and \(date.formatted())"
    }
    
    func randomString() -> String {
        ""
    }
    
    func randomLongString() -> String {
        ""
    }
    
    
    func shortLatinString() -> String {
        "Lorem ipsum dolor sit amet."
    }
    
    func longLatinString() -> String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    
    // MARK: Int
    
    func randomInt(_ upper: Int? = nil) -> Int {
        if let upper {
            Int(arc4random_uniform(UInt32(upper)))
        } else {
            Int(arc4random())
        }
    }
    
    func randomIntBetween(_ lower: Int, _ upper: Int) -> Int {
        Int.random(in: lower...upper)
    }
    
    // MARK: Double
    
    func randomDoubleBetween(_ lower: Double, _ upper: Double) -> Double {
        Double.random(in: lower...upper)
    }
    
    func randomDouble() -> Double {
        Double(randomInt()) + randomTinyDouble()
    }
    
    func randomTinyDouble() -> Double {
        drand48()
    }
    
    
    
    // MARK: Float
    
    
    // TODO: Need to test this
    func randomFloat() -> Float {
        let intOne = Float(randomInt())
        let intTwo = Float(randomInt())
        if intOne < intTwo {
            return Float.random(in: intOne...intTwo)
        } else {
            return Float.random(in: intTwo...intOne)
        }
    }
    
    func randomFloatBetween(_ lower: Float, _ upper: Float) -> Float {
        Float.random(in: lower...upper)
    }
    
    
    
    
    // MARK: Coordinates
    
    func randomCoordinates() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: randomLatitude(), longitude: randomLongitude())
    }
    
    func randomLatitude() -> Double {
        return Double.random(in: -90.000..<90.000)
    }
    
    func randomLongitude() -> Double {
        return Double.random(in: -180.000..<180.000)
    }
    
    
    // MARK: Date
    
    
    
    // TODO: Need to test this
    func randomDateBetween(_ lower: Date = Date.distantPast, _ upper: Date = Date.distantFuture) -> Date {
        var date1 = lower
        var date2 = upper
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }
    
    
    
    
    // MARK: Generic
    
    func randomArray<T>(_ randomFunc: () -> T, _ quantity: Int) -> [T] {
        var array: [T] = []
        for _ in 1...quantity {
            array.append(randomFunc())
        }
        return array
    }
    
//    Numeric ????
//    RandomNumberGenerator
//    Comparable
//    FixedWidthInteger
//    BinaryFloatingPoint
//    func randomBetween<T: FixedWidthInteger>(_ lower: T, _ upper: T) -> T {
//        T.random(in: lower...upper)
//    }
    
    
    
}
