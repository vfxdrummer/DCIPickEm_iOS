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
      let events:[Event] = []
      for child in snapshot.children {
        
      }
      CurrentEventItems.sharedInstance.events = events
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}
