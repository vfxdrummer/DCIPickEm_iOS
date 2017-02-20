//
//  LineupInterface.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 2/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseDatabase

class LineupInterface: NSObject {
  
  /**
   getEvents
   Get Event list from Firebase DB
   */
  class func getLineup(eventId: String) {
    let ref = FIRDatabase.database().reference()
    
    ref.child("lineups").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let lineupArray = snapshot.value as? [String] else {
        return
      }
      let lineup = Lineup.init(lineupArray: lineupArray as! [String])
      CurrentContestItems.sharedInstance.lineup = lineup
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}
