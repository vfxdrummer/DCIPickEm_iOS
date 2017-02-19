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
  var date : String = ""
  var date_label : String = ""
  var location : String = ""
  var time : Date = NSDate() as Date
  
  
  init(eventDict: Dictionary<String, String>) {
    super.init()
//      self.id                    = eventDict["id"]
    if let name = eventDict["name"] {
      self.name = name
    }
    if let date = eventDict["date"] {
      self.date = date
    }
    if let date_label = eventDict["date_label"] {
      self.date_label = date_label
    }
    if let location = eventDict["location"] {
      self.location = location
    }
    if let time = eventDict["time"] {
//      self.time = 
    }
  }
}
