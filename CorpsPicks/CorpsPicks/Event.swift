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
}
