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
   getLineup
   Get Lineup list from Firebase DB
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
  
  /**
   getScorePicks
   Get User score picks for lineup from Firebase DB
   */
  class func getScorePicks(eventId:String, userId:String) {
    let ref = FIRDatabase.database().reference()
    
    // walk lineup for eventId
    ref.child("lineups").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let lineupArray = snapshot.value as? [String] else {
        return
      }
      
      // walk picks for eventId
      ref.child("picks").child(eventId).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
        // grab array of scores for corps, else fill with 0's
        var scoreArray = snapshot.value as? [String]
        if (scoreArray == nil) {
          _ = lineupArray.map({_ in 
            if (scoreArray?.append("0")) == nil {
              scoreArray = ["0"]
            }
          })
        }
        // create formal array of CorpsScore objects
        var corpsScores:[CorpsScore] = []
        for (index, element) in lineupArray.enumerated() {
          let corpsScore = ContestInterface.getCorpsScore(corpsId: element, score:(scoreArray?[index])!)
          corpsScores.append(corpsScore!)
        }
        CurrentContestItems.sharedInstance.corpsScores = corpsScores
      }) { (error) in
        print(error.localizedDescription)
      }
    }) { (error) in
      print(error.localizedDescription)
    }
  }
  
  class func getCorpsScore(corpsId:String, score:String) -> CorpsScore? {
    let corps:Corps = CorpsInterface.getCorpsById(corpsId:corpsId)
    let score:Score = Score.init(score: score)
    return CorpsScore.init(corps:corps, score:score)
  }
}
