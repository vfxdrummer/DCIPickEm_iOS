//
//  Event.swift
//  EventPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class Event : NSObject {
  var id : String = ""
  var name : String = ""
  var date : Date = Date()
  var date_label : String = ""
  var location : String = ""
  var imageName : String = ""
  var pickStatus : Bool = false
  var time : Date = Date()
  var lineup : [String : Corps] = [:]
  var scores : [Corps : Float] = [:]
  
  init(eventDict: Dictionary<String, String>) {
    super.init()
    if let id = eventDict["id"] {
      self.id = id
    }
    if let name = eventDict["name"] {
      self.name = name
    }
    if let date = eventDict["date"],
      let time = eventDict["time"] {
      self.date = parseFirebaseDate(dateString: date, timeString: time)
    }
    if let date_label = eventDict["date_label"] {
      self.date_label = date_label
    }
    if let location = eventDict["location"] {
      self.location = location
    }
    if let imageName = eventDict["image"] {
      self.imageName = imageName
    }
    if let time = eventDict["time"] {
      self.time = parseFirebaseTime(timeString: time)
    }
  }
  
  // Parsers
  
  func parseFirebaseTime(timeString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    var tokens1 = timeString.components(separatedBy:":")
    if tokens1.count < 2 { return Date() }
    var tokens2 = tokens1[1].components(separatedBy:" ")
    var hour = tokens1[0]
    if hour.characters.count == 1 {
      hour = "0\(hour)"
    }
    if (tokens2[1] == "p.m.") {
      hour = String(Int(hour)! + 12)
    }
    let minute = tokens2[0]
    let timeFormatString = "\(hour):\(minute)"
    print(timeFormatString)
    let time: Date? = dateFormatter.date(from: timeFormatString)
    return time!
  }
  
  func parseFirebaseTimeZone(timeString: String) -> String {
    var tokens = timeString.components(separatedBy:" ")
    var timeZone = ""
    if (tokens[2] == "(ET)") {
      timeZone = "EST"
    }
    if (tokens[2] == "(CT)") {
      timeZone = "CST"
    }
    if (tokens[2] == "(PT)") {
      timeZone = "PST"
    }
    return timeZone
  }
  
  func parseFirebaseDate(dateString: String, timeString: String) -> Date {
    print("\n\ndateString : \(dateString) timeString : \(timeString)")
    // get hours and minutes
    let timeDate = parseFirebaseTime(timeString: timeString)
    let timeZone = parseFirebaseTimeZone(timeString: timeString)
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: timeDate)
    let minutes = calendar.component(.minute, from: timeDate)
    
    // format total date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
    let characters = dateString.characters.map { String($0) }
    let dateFormatString = "20\(characters[0])\(characters[1])-\(characters[2])\(characters[3])-\(characters[4])\(characters[5]) \(hour):\(minutes):00"
    print("\(dateFormatString)")
    var date: Date? = dateFormatter.date(from: dateFormatString)
    date = Calendar.current.date(byAdding: .day, value: -1, to: date!)
    print("date : \(date)")
    
    if (date == nil) {
      return Date()
    }
    
//    // convert to UTC
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
//    dateFormatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
//    let dateStringUTC = dateFormatter.string(from: date!)
//    print("Date() : \(Date())")
//    print("date1 : \(dateStringUTC)")
//    
    
    return date!
  }
  
  func printDateComponents(date: Date) {
    let calendar = Calendar.current
    
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    
    print("\(year) \(month) \(day) \(hour) \(minutes) ")
  }
  
  func parseLineupRowString(rowString: String) {
    var tokens = rowString.components(separatedBy:":")
    if (tokens.count == 2) {
      let index = tokens[0].replacingOccurrences(of: "\0", with: "", options: NSString.CompareOptions.literal, range:nil)
      let corpsString = tokens[1].replacingOccurrences(of: "\0", with: "", options: NSString.CompareOptions.literal, range:nil)
      
      lineup[index] = CorpsInterface.getCorpsById(corpsId:corpsString)
    }
  }
  
}

extension NSDate {
  convenience init(utcDate:String, dateFormat:String="yyyy-MM-dd HH:mm:ss.SSS+00:00") {
    // 2016-06-06 00:24:21.164493+00:00
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    dateFormatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
    
    let date = dateFormatter.date(from: utcDate)!
    let s = NSTimeZone.local.secondsFromGMT(for: date)
    let timeInterval = TimeInterval(s)
    
    self.init(timeInterval: timeInterval, since:date)
  }
}
