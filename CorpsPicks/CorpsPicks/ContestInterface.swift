//
//  ContestInterface.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 2/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseDatabase

class ContestInterface: NSObject {
  
  /**
   getEvents
   Get Event list from Firebase DB
   */
  class func getContest(eventId: String) {
    let ref = FIRDatabase.database().reference()
    
    ref.child("lineups").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let contestArray = snapshot.value as? [String] else {
        return
      }
      let contest = Contest.init(contestArray: contestArray as! [String])
      CurrentContestItems.sharedInstance.contest = contest
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}
