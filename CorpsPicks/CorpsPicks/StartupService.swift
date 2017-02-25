//
//  StartupService.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Earbits. All rights reserved.
//

import UIKit

class StartupService: NSObject {
  
  static let sharedInstance : StartupService = StartupService()
  
  //  MARK: Startup Methods
  
  /**
   start
   Setup the various services and make various calls necessary to run the application
   TODO:  Is somewhat brittle and would like to have this adopt certain things executed in AppDelegate (where this call is made).
   */
  func start() {
    CorpsInterface.getCorps()
  }
}
