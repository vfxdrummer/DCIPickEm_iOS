//
//  EventInterface.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 2/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseDatabase

class EventInterface: NSObject {
  
  /**
   getEvents
   Get Event list from Firebase DB
   */
  class func getEvents(maxItems:Int) {
    let useMaxItems = (maxItems != -1) ? true : false
    let ref = Database.database().reference()
    let eventsRef = ref.child("2017/v1/events")
    var i = 0
    eventsRef.observe(.value, with: { snapshot in
      var events:[Event] = []
      for event in snapshot.children.allObjects as! [DataSnapshot] {
        // check for max items
        if (useMaxItems == true && i >= maxItems) {
          continue
        }
        guard let eventDict = event.value as? [String: AnyObject] else {
          continue
        }
        var eventDictNew = eventDict
        eventDictNew["id"] = event.key as String? as AnyObject?
        let event = Event.init(eventDict: eventDictNew as! Dictionary<String, String>)
        events.append(event)
        i += 1
      }
      CurrentEventItems.sharedInstance.events = events
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}

