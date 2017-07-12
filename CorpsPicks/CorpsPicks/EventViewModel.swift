//
//  EventViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class EventViewModel: CPViewModel, CurrentEventProtocol {
  
  var events : [Event] {
    get {
      return CurrentEventItems.sharedInstance.events
    }
  }
  var pastEvents : [Event] {
    get {
      return CurrentEventItems.sharedInstance.events.filter { $0.isComplete == true || $0.isExhibition || $0.isRainout }
    }
  }
  var futureEvents : [Event] {
    get {
      return CurrentEventItems.sharedInstance.events.filter { $0.isComplete == false && $0.isExhibition == false && $0.isRainout == false }
    }
  }
  var initialLoad : Bool = true
  
  func setup() {
    CurrentEventItems.sharedInstance.delegate = self
  }
  
  /**
   loadLeaderboard
   Fetch leaderboard
   */
  func loadEvents() {
    initialLoad = false
    EventInterface.getEvents(maxItems: -1)
  }
  
  // CurrentEventProtocol
  
  func updateEvents(events:[Event]) {
    if (initialLoad == true) {
      loadEvents()
    }
    if let view = self.vc as? EventView {
      view.loadEvents(events: events)
    }
  }
  
}

