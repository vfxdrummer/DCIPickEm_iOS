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
    if let date = eventDict["date"] {
      self.date = parseFirebaseDate(dateString: date)
    }
    if let date_label = eventDict["date_label"] {
      self.date_label = date_label
    }
    if let location = eventDict["location"] {
      self.location = location
    }
    if let time = eventDict["time"] {
      self.time = parseFirebaseTime(timeString: time)
    }
  }
  
  // Parsers
  
  func parseFirebaseTime(timeString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm"
    
    var tokens1 = timeString.components(separatedBy:":")
    if tokens1.count < 2 { return Date() }
    var tokens2 = tokens1[1].components(separatedBy:" ")
    var hour = tokens1[0]
    if hour.characters.count == 1 {
      hour = "0\(hour)"
    }
    let minute = tokens2[0]
    let timeFormatString = "\(hour):\(minute)"
    let time: Date? = dateFormatter.date(from: timeFormatString)
    return time!
  }
  
  func parseFirebaseDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    let characters = dateString.characters.map { String($0) }
    let dateFormatString = "20\(characters[0])\(characters[1])-\(characters[2])\(characters[3])-\(characters[4])\(characters[5]) 00:00:00"
    let date: Date? = dateFormatter.date(from: dateFormatString)
    return date!
  }
  
  func parseLineupRowString(rowString: String) {
    var tokens = rowString.components(separatedBy:":")
    if (tokens.count == 2) {
      let index = tokens[0].replacingOccurrences(of: "\0", with: "", options: NSString.CompareOptions.literal, range:nil)
      let corpsString = tokens[1].replacingOccurrences(of: "\0", with: "", options: NSString.CompareOptions.literal, range:nil)
      
      lineup[index] = Corps.init(corpsString: corpsString)
    }
  }
  
}
