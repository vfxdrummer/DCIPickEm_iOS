//
//  Contest.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

enum StoryboardName : String {
  case Main = "Main"
  case Onboarding = "Onboarding"
}

class Constants: NSObject {
  
  // titles
  let contestTitle : String = NSLocalizedString("CONTEST_TITLE", comment: "")
  
  // facebook auth
  let faceBookAppId = "263416347402894"
  let faceBookAppSecret = "24cbbbe9f011c4247d52293f8f8d47b3"
  
}
