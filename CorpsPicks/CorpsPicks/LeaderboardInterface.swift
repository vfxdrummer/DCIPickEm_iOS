//
//  LeaderboardInterface.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 4/11/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseDatabase

class LeaderboardInterface: NSObject {
  
  /**
   getLeaderboard
   Get Leaderboard list from Firebase DB
   */
  class func getLeaderboard(eventId: String) {
//    let ref = FIRDatabase.database().reference()
    
//    ref.child("lineups").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
//      guard let lineupArray = snapshot.value as? [String] else {
//        return
//      }
//      let lineup = Lineup.init(lineupArray: lineupArray as! [String])
//      CurrentContestItems.sharedInstance.lineup = lineup
//    }) { (error) in
//      print(error.localizedDescription)
//    }
    
    let leaderboardDict:Dictionary<String, AnyObject> = [:]
    let leaderboard = Leaderboard(leaderboardDict: leaderboardDict)
    
    CurrentLeaderboardItems.sharedInstance.leaderboard = leaderboard
  }
}
