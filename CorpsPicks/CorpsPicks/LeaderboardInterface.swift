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
        let ref = FIRDatabase.database().reference()
        
        ref.child("leaderboard").child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let leaderboardDict = snapshot.value as? [String:String] else {
                return
            }
            let leaderboard = Leaderboard.init(leaderboardDict: leaderboardDict as! Dictionary<String, AnyObject>)
            leaderboard.id = eventId
            CurrentLeaderboardItems.sharedInstance.leaderboard = leaderboard
        }) { (error) in
            print(error.localizedDescription)
        }
        
        let leaderboardDict:Dictionary<String, AnyObject> = [:]
        let leaderboard = Leaderboard(leaderboardDict: leaderboardDict)
        
        CurrentLeaderboardItems.sharedInstance.leaderboard = leaderboard
    }
}
