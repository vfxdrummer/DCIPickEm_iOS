//
//  LoginViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class LoginViewModel: CPViewModel, CurrentEventProtocol {
  
  var events : [Event] {
    get {
      return CurrentEventItems.sharedInstance.events
    }
  }
  
  func setup() {
    CurrentEventItems.sharedInstance.delegate = self
  }
  
  /**
   loadLeaderboard
   Fetch leaderboard
   */
  func loadEvents() {
    EventInterface.getEvents()
  }
  
  // CurrentEventProtocol
  
  func updateEvents(events:[Event]) {
    if let view = self.vc as? EventView {
      view.loadEvents(events: events)
    }
  }
  
}

