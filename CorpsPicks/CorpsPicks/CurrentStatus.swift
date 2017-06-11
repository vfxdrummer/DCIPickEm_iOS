//
//  CPViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit

//  MARK: CurrentCorpsItems
protocol CurrentCorpsProtocol {
  func updateCorps(corps:[String:Corps])
}
class CurrentCorpsItems : NSObject {
  static let sharedInstance = CurrentCorpsItems()
  private var delegates : [CurrentCorpsProtocol] = []
  
  var delegate : CurrentCorpsProtocol? = nil {
    didSet {
      delegates.append(delegate!)
    }
  }
  var corps : [String:Corps] = [:] {
    didSet {
      _ = delegates.map({
        $0.updateCorps(corps: corps)
      })
    }
  }
}

//  MARK: CurrentEventItems
protocol CurrentEventProtocol {
  func updateEvents(events:[Event])
}
class CurrentEventItems : NSObject {
  static let sharedInstance = CurrentEventItems()
  private var delegates : [CurrentEventProtocol] = []
  
  var delegate : CurrentEventProtocol? = nil {
    didSet {
      delegates.append(delegate!)
    }
  }
  var events : [Event] = [] {
    didSet {
      _ = delegates.map({
        $0.updateEvents(events: events)
      })
    }
  }
}

//  MARK: CurrentContestItems
protocol CurrentContestProtocol {
  func updateLineup(lineup:Lineup)
  func updateScores(corpsScores:[CorpsScore])
  func updateInitialScoresDismissed(initialScoresDismissed:Bool)
  func updatePlacementOnly(placementOnly:Bool)
}
class CurrentContestItems : NSObject {
  static let sharedInstance = CurrentContestItems()
  private var delegates : [CurrentContestProtocol] = []
  
  var delegate : CurrentContestProtocol? = nil {
    didSet {
      delegates.append(delegate!)
    }
  }
  var locked : Bool {
    return false
  }
  var lineup : Lineup? {
    didSet {
      _ = delegates.map({
        $0.updateLineup(lineup:lineup!)
      })
    }
  }
  var corpsScores : [CorpsScore] = [] {
    didSet {
      _ = delegates.map({
        $0.updateScores(corpsScores:corpsScores)
      })
    }
  }
  var initialScoresDismissed : Bool = false {
    didSet {
      _ = delegates.map({
        $0.updateInitialScoresDismissed(initialScoresDismissed:initialScoresDismissed)
      })
    }
  }
  var placementOnly : Bool = true {
    didSet {
      _ = delegates.map({
        $0.updatePlacementOnly(placementOnly:placementOnly)
      })
    }
  }
}
  
//  MARK: CurrentLeaderboardItems
protocol CurrentLeaderboardProtocol {
    func updateLeaderboard(leaderboard:Leaderboard)
}
class CurrentLeaderboardItems : NSObject {
    static let sharedInstance = CurrentLeaderboardItems()
    private var delegates : [CurrentLeaderboardProtocol] = []
    
    var delegate : CurrentLeaderboardProtocol? = nil {
        didSet {
            delegates.append(delegate!)
        }
    }
    var leaderboard : Leaderboard? {
        didSet {
            _ = delegates.map({
                $0.updateLeaderboard(leaderboard:leaderboard!)
            })
        }
    }
}

