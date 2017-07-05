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
    print("eventId : \(eventId)")
    let ref = Database.database().reference()
    
    ref.child("2017/v1/leaderboard").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
      
      ref.child("2017/v1/leaderboard").child(eventId).child("placement").observeSingleEvent(of: .value, with: { (snapshot) in
        for _ in snapshot.children.allObjects as! [DataSnapshot] {
          guard let leaderboardDict = snapshot.value as? [String:AnyObject] else {
            continue
          }
          _ = Leaderboard.init(leaderboardDict: leaderboardDict as Dictionary<String, AnyObject>, onSuccess: { leaderboard in
            leaderboard.id = eventId
            CurrentLeaderboardItems.sharedInstance.placement = leaderboard
          })
        }
        
      }) { (error) in
        print(error.localizedDescription)
      }
      
      ref.child("2017/v1/leaderboard").child(eventId).child("scores").observeSingleEvent(of: .value, with: { (snapshot) in
        for _ in snapshot.children.allObjects as! [DataSnapshot] {
          guard let leaderboardDict = snapshot.value as? [String:AnyObject] else {
            continue
          }
          _ = Leaderboard.init(leaderboardDict: leaderboardDict as Dictionary<String, AnyObject>, onSuccess: { leaderboard in
            leaderboard.id = eventId
            CurrentLeaderboardItems.sharedInstance.scores = leaderboard
          })
        }
        
      }) { (error) in
        print(error.localizedDescription)
      }
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}
