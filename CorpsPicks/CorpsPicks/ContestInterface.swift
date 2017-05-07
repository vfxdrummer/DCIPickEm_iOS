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
   setDefaultScorePicks
   Get User score picks for lineup from Firebase DB
   */
  class func setDefaultScorePicks(eventId:String) {
    let ref = FIRDatabase.database().reference()
    
    ref.child("lineups").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let lineupArray = snapshot.value as? [String] else {
        return
      }
      
      // create formal array of CorpsScore objects
      var corpsScores:[CorpsScore] = []
      for (index, element) in lineupArray.enumerated() {
        let corpsScore = ContestInterface.getCorpsScore(corpsId: element, score:(lineupArray[index]))
        corpsScores.append(corpsScore!)
      }
      CurrentContestItems.sharedInstance.corpsScores = corpsScores
      
      
    }) { (error) in
      print(error.localizedDescription)
    }
  }
  
  /**
   getScorePicks
   Get User score picks for lineup from Firebase DB
   */
  class func getScorePicks(eventId:String) {
    // move this to singleton, set on Auth
    let userId = CurrentUser.sharedInstance.uid
    
    let ref = FIRDatabase.database().reference()
    
    // observe picks
    ref.child("picks").observeSingleEvent(of: .value, with: { (snapshot) in
      
      if snapshot.hasChild(eventId){
        
        // observe picks eventId
        ref.child("picks").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
          
          if snapshot.hasChild(userId){
            
            var nameArray:Array<String> = []
            var scoreArray:Array<String> = []
            
            // observe userId name
            ref.child("picks").child(eventId).child(userId).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
              
              nameArray = (snapshot.value as? [String])!
              
              // observe userId score
              ref.child("picks").child(eventId).child(userId).child("score").observeSingleEvent(of: .value, with: { (snapshot) in
                
                scoreArray = (snapshot.value as? [String])!
                
                // create formal array of CorpsScore objects
                var corpsScores:[CorpsScore] = []
                for (index, element) in nameArray.enumerated() {
                  let corpsScore = ContestInterface.getCorpsScore(corpsId: element, score:(scoreArray[index]))
                  corpsScores.append(corpsScore!)
                }
                CurrentContestItems.sharedInstance.corpsScores = corpsScores
                
              }) { (error) in
                print(error.localizedDescription)
              }
              
            }) { (error) in
              print(error.localizedDescription)
            }
            
          } else {
            ContestInterface.setDefaultScorePicks(eventId: eventId)
          }
          
        }) { (error) in
          print(error.localizedDescription)
        }
        
      } else {
        ContestInterface.setDefaultScorePicks(eventId: eventId)
      }
      
    }) { (error) in
      print(error.localizedDescription)
    }
  }
  
  class func setScorePicks(eventId:String, corpsScores:[CorpsScore]) {
    // move this to singleton, set on Auth
    let userId = CurrentUser.sharedInstance.uid
    
    let ref = FIRDatabase.database().reference()
    print("Setting scores for \(eventId)")
    for corpsScore in corpsScores {
      print("\(corpsScore.corps.name) \(corpsScore.score)")
      var corpsNameArray:Array<Any> = []
      _ = corpsScores.map({
        corpsNameArray.append($0.corps.name)
      })
      var corpsScoreArray:Array<Any> = []
      _ = corpsScores.map({
        corpsScoreArray.append($0.score.pick)
      })
      let picksRef = ref.child("/picks")
      let eventRef = picksRef.child("/\(eventId)")
      let userRef = eventRef.child("/\(userId)")
      userRef.child("name").setValue(corpsNameArray)
      userRef.child("score").setValue(corpsScoreArray)
    }
  }
  
  class func getCorpsScore(corpsId:String, score:String) -> CorpsScore? {
    let corps:Corps = CorpsInterface.getCorpsById(corpsId:corpsId)
    let score:Score = Score.init(score: score)
    return CorpsScore.init(corps:corps, score:score)
  }
}
