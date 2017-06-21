//
//  StartupService.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Earbits. All rights reserved.
//

import UIKit

class StartupService: CurrentEventProtocol {
  
  static let sharedInstance : StartupService = StartupService()
  
  public var defaultEventId : String? = "7267157"
  
  //  MARK: Startup Methods
  
  /**
   start
   Setup the various services and make various calls necessary to run the application
   TODO:  Is somewhat brittle and would like to have this adopt certain things executed in AppDelegate (where this call is made).
   */
  func start() {
    // set delegates
    CurrentEventItems.sharedInstance.delegate = self
    
    // front load api items
    CorpsInterface.getCorps()
    EventInterface.getEvents(maxItems: 10)
  }
  
  func updateEvents(events:[Event]) {
    guard (events.count > 0) else {
      return
    }
    self.defaultEventId = events.first?.id
  }
}
