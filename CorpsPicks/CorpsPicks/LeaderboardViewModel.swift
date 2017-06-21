//
//  LeaderboardViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class LeaderboardViewModel: CPViewModel, CurrentLeaderboardProtocol {
  
  var placement : Leaderboard? {
    get {
      return CurrentLeaderboardItems.sharedInstance.placement
    }
  }
  
  var scores : Leaderboard? {
    get {
      return CurrentLeaderboardItems.sharedInstance.scores
    }
  }
  
  var placementScores : [UserScore] {
    get {
      if let leaderboard = self.placement {
        return leaderboard.userScores
      }
      return []
    }
  }
  
  var scoresScores : [UserScore] {
    get {
      if let leaderboard = self.scores {
        return leaderboard.userScores
      }
      return []
    }
  }
  
  var hasData : Bool = false
  
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
  
  func updatePlacementLeaderboard(leaderboard:Leaderboard) {
    hasData = true
    if let view = self.vc as? LeaderboardView {
      view.reload()
    }
  }
  
  func updateScoresLeaderboard(leaderboard:Leaderboard) {
    hasData = true
    if let view = self.vc as? LeaderboardView {
      view.reload()
    }
  }
  
}

