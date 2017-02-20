//
//  CPViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit

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
}
class CurrentContestItems : NSObject {
  static let sharedInstance = CurrentContestItems()
  private var delegates : [CurrentContestProtocol] = []
  
  var delegate : CurrentContestProtocol? = nil {
    didSet {
      delegates.append(delegate!)
    }
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
}

