//
//  Lineup.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class Lineup : NSObject {
  var event_id : String = ""
  var lineup : [String : Corps] = [:]
  var scores : [Corps : Float] = [:]
  
  init(lineupArray: [String]) {
    super.init()
    for rowString:String in lineupArray {
      parseLineupRowString(rowString: rowString)
    }
  }
  
  func parseLineupRowString(rowString: String) {
    var tokens = rowString.components(separatedBy:":")
    if (tokens.count == 2) {
      let index = tokens[0].replacingOccurrences(of: "\0", with: "", options: NSString.CompareOptions.literal, range:nil)
      let corpsString = tokens[1].replacingOccurrences(of: "\0", with: "", options: NSString.CompareOptions.literal, range:nil)
      
      lineup[index] = Corps.init(corpsString: corpsString)
    }
  }
  
}


