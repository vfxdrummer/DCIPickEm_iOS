//
//  LeaderboardViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class LeaderboardViewModel: CPViewModel, CurrentLeaderboardProtocol {
  
  var leaderboard : Leaderboard {
    get {
      return CurrentLeaderboardItems.sharedInstance.leaderboard!
    }
  }

//  var corpsScores : [CorpsScore] = []
  var eventId : String? = nil
  
  func setup(eventId:String) {
    self.eventId = eventId
    CurrentLeaderboardItems.sharedInstance.delegate = self
  }
  
  func loadLineup() {
    guard (eventId != nil) else { return }
    ContestInterface.getLineup(eventId:eventId!)
    ContestInterface.getScorePicks(eventId:eventId!)
  }
  
  // CurrentLeaderboardProtocol
    
  func updateLeaderboard(leaderboard:Leaderboard) {
    if let view = self.vc as? LeaderboardView {
      view.reload()
    }
  }
  
}

