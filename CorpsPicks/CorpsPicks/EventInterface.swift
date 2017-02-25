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
  class func getEvents() {
    let ref = FIRDatabase.database().reference()
    let eventsRef = ref.child("events")
    eventsRef.observe(.value, with: { snapshot in
      var events:[Event] = []
      for _ in snapshot.children {
        for event in snapshot.children.allObjects as! [FIRDataSnapshot] {
          guard let eventDict = event.value as? [String: AnyObject] else {
            continue
          }
          var eventDictNew = eventDict
          eventDictNew["id"] = event.key as String? as AnyObject?
          let event = Event.init(eventDict: eventDictNew as! Dictionary<String, String>)
          events.append(event)
        }
      }
      CurrentEventItems.sharedInstance.events = events
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}