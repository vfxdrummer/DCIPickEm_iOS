//
//  LeaderboardViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class LeaderboardViewModel: CPViewModel, CurrentLeaderboardProtocol {
    
    var leaderboard : Leaderboard? {
        get {
            return CurrentLeaderboardItems.sharedInstance.leaderboard
        }
    }
    
    var userScores : [UserScore] {
        get {
            if let leaderboard = self.leaderboard {
                return leaderboard.userScores
            }
            return []
        }
    }
    
    var eventId : String? = nil
    
    func setup(eventId:String) {
        self.eventId = eventId
        CurrentLeaderboardItems.sharedInstance.delegate = self
    }
    
    func loadLeaderboard() {
        guard (eventId != nil) else { return }
        LeaderboardInterface.getLeaderboard(eventId:eventId!)
    }
    
    // CurrentLeaderboardProtocol
    
    func updateLeaderboard(leaderboard:Leaderboard) {
        if let view = self.vc as? LeaderboardView {
            view.reload()
        }
    }
    
}

