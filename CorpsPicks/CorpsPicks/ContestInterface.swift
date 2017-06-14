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
    let ref = Database.database().reference()
    print("getLineup(eventId:\(eventId))")
    
    ref.child("2017/v1/lineups").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let lineupArray = snapshot.value as? [String] else {
        return
      }
      let lineup = Lineup.init(lineupArray: lineupArray )
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
    let ref = Database.database().reference()
    
    ref.child("2017/v1/lineups").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
      guard let lineupArray = snapshot.value as? [String] else {
        return
      }
      
      // create formal array of CorpsScore objects
      var corpsScores:[CorpsScore] = []
      for (index, element) in lineupArray.enumerated() {
        let corpsScore = ContestInterface.getCorpsScore(corpsId: element, score:(lineupArray[index]))
        corpsScore!.score.pick = "50.0"
        corpsScores.append(corpsScore!)
      }
      CurrentContestItems.sharedInstance.corpsScores = corpsScores
      
      
    }) { (error) in
      print(error.localizedDescription)
    }
  }
  
  /**
   contestPickStatus
   Does the user have picks for the event?
   */
  class func getContestPickStatus(eventId:String, onSuccess:@escaping ()->(), onFailure:@escaping ()->()) {
    // move this to singleton, set on Auth
    let userId = CurrentUser.sharedInstance.uid
    
    let ref = Database.database().reference()
    
    // initial metadata settings for eventID (in case there is no entry)
    CurrentContestItems.sharedInstance.initialScoresDismissed = false
    
    // observe picks
    ref.child("2017/v1/picks").observeSingleEvent(of: .value, with: { (snapshot) in
      
      if snapshot.hasChild(eventId) {
        
        // observe picks eventId
        ref.child("2017/v1/picks").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
          
          if snapshot.hasChild(userId){
            // has user entry for picks/$eventId !
            onSuccess()
            return
          }
        })
      }
      
      onFailure()
    })
  }
  
  
  /**
   getScorePicks
   Get User score picks for lineup from Firebase DB
   */
  class func getScorePicks(eventId:String) {
    // move this to singleton, set on Auth
    let userId = CurrentUser.sharedInstance.uid
    
    let ref = Database.database().reference()
    
    // initial metadata settings for eventID (in case there is no entry)
    CurrentContestItems.sharedInstance.initialScoresDismissed = false
    
    // observe picks
    ref.child("2017/v1/picks").observeSingleEvent(of: .value, with: { (snapshot) in
      
      if snapshot.hasChild(eventId){
        
        // observe picks eventId
        ref.child("2017/v1/picks").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
          
          if snapshot.hasChild(userId){
            
            var nameArray:Array<String> = []
            var scoreArray:Array<String> = []
            
            // observe userId name
            ref.child("2017/v1/picks").child(eventId).child(userId).child("name").observeSingleEvent(of: .value, with: { (snapshot) in
              
              nameArray = (snapshot.value as? [String])!
              
              // observe userId score
              ref.child("2017/v1/picks").child(eventId).child(userId).child("score").observeSingleEvent(of: .value, with: { (snapshot) in
                
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
              
              // check for metadata
              ref.child("2017/v1/picks").child(eventId).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                // check for metadata
                if snapshot.hasChild("metadata") {
                  
                  // check for initialScoresDismissed
                  ref.child("2017/v1/picks").child(eventId).child(userId).child("metadata").observeSingleEvent(of: .value, with: { (snapshot) in
      
                    // check for initialScoresDismissed
                    if snapshot.hasChild("initialScoresDismissed") {
                      CurrentContestItems.sharedInstance.initialScoresDismissed = true
                    }
                    
                    // check for initialScoresDismissed
                    if snapshot.hasChild("placementOnly") {
                      ref.child("2017/v1/picks").child(eventId).child(userId).child("metadata").child("placementOnly").observeSingleEvent(of: .value, with: { (snapshot) in
                        CurrentContestItems.sharedInstance.placementOnly = (snapshot.value as? Bool)!
                      })
                    }
                  }) { (error) in
                    // observe metadata
                    print(error.localizedDescription)
                  }
                }
              }) { (error) in
                // observe picks / userId
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
    
    let ref = Database.database().reference()
//    print("Setting scores for \(eventId)")
    for _ in corpsScores {
      var corpsNameArray:Array<Any> = []
      _ = corpsScores.map({
        corpsNameArray.append($0.corps.name)
      })
      var corpsScoreArray:Array<Any> = []
      _ = corpsScores.map({
        corpsScoreArray.append($0.score.pick)
      })
      let picksRef = ref.child("2017/v1//picks")
      let eventRef = picksRef.child("/\(eventId)")
      let userRef = eventRef.child("/\(userId)")
      userRef.child("name").setValue(corpsNameArray)
      userRef.child("score").setValue(corpsScoreArray)
    }
  }
  
  // getEventMetadataRef
  // utility to get metadata ref
  class func getEventMetadataRef(eventId:String) -> DatabaseReference {
    // move this to singleton, set on Auth
    let userId = CurrentUser.sharedInstance.uid
    
    let ref = Database.database().reference()
    let picksRef = ref.child("2017/v1//picks")
    let eventRef = picksRef.child("/\(eventId)")
    let userRef = eventRef.child("/\(userId)")
    let metadataRef = userRef.child("/metadata")
    return metadataRef
  }
  
  class func setInitialScoresDismissed(eventId:String) {
    let metadataRef = ContestInterface.getEventMetadataRef(eventId: eventId)
    metadataRef.child("initialScoresDismissed").setValue(true)
  }
  
  class func setPlacementsOnly(eventId: String, placementOnly: Bool) {
    let metadataRef = ContestInterface.getEventMetadataRef(eventId: eventId)
    metadataRef.child("placementOnly").setValue(placementOnly)
  }
  
//  class func getPlacementsOnly(eventId: String) -> Bool {
//    let metadataRef = ContestInterface.getEventMetadataRef(eventId: eventId)
//    metadataRef.child("placementOnly")
//  }
  
  class func checkScoreString(score:String) -> String {
    // ensure they are digits
    var doubleValue : Double = NSString(string: score).doubleValue
    doubleValue = (doubleValue >= 0.0) ? doubleValue : 0.0
    doubleValue = (doubleValue <= 100.0) ? doubleValue : 100.0
    return "\(doubleValue)"
  }
  
  class func getCorpsScore(corpsId:String, score:String) -> CorpsScore? {
    let corps:Corps = CorpsInterface.getCorpsById(corpsId:corpsId)
    let score:Score = Score.init(score: checkScoreString(score: score))
    return CorpsScore.init(corps:corps, score:score)
  }
}
