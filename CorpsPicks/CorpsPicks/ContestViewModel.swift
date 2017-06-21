
//
//  ContestViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestViewModel: CPViewModel, CurrentContestProtocol {
  
  private var lastEventId : String? = nil
  public var eventId : String {
    get {
      return CurrentContestItems.sharedInstance.eventId
    }
  }
  
  public var eventName : String {
    get {
      return CurrentContestItems.sharedInstance.eventName
    }
  }
  
  public var lineup : Lineup {
    get {
      return CurrentContestItems.sharedInstance.lineup!
    }
  }
  
  public var resultPickPlacements : [Int] = []
  public var resultScores : [CorpsScore] {
    get {
      return CurrentContestItems.sharedInstance.resultScores
    }
  }

  public var corpsScores : [CorpsScore] = [] {
    didSet {
      setScorePicks()
    }
  }
  
  var madePicks : Bool {
    get {
      return CurrentContestItems.sharedInstance.madePicks
    }
  }
  
  var isComplete : Bool {
    get {
      return CurrentContestItems.sharedInstance.isComplete
    }
  }
  
  var locked : Bool {
    get {
      return CurrentContestItems.sharedInstance.locked
    }
  }
  
  var initialScoresDismissed : Bool {
    get {
      return CurrentContestItems.sharedInstance.initialScoresDismissed
    }
  }
  
  var placementOnly : Bool {
    get {
      return CurrentContestItems.sharedInstance.placementOnly
    }
  }
  
  func setup() {
    CurrentContestItems.sharedInstance.delegate = self
  }
  
  func loadLineup() {
    print("ContestVM : loadLineup")
    ContestInterface.getLineup(eventId:eventId)
    ContestInterface.getScorePicks(eventId:eventId)
    ContestInterface.getResults(eventId:eventId)
  }
  
  // setInitialScores
  // set corpsPicks using initial scores
  func setInitialScores() {
    guard (locked == false) else {
      return
    }
    // update corpsScores using initial score
    let newCorpsScores = self.corpsScores
    for corpsScore in newCorpsScores {
      corpsScore.score.pick = corpsScore.corps.lastScore
    }
    // set new corpsScores
    self.corpsScores = newCorpsScores
    
    self.sortCorpsScores(completion : { [unowned self] _ in
      // save new corps scores, trigger UI update
      self.setScorePicks()
    })
  }
  
  // setOptionSwitch
  // value of 'use placements only'
  func setOptionSwitch(value: Bool) {
    guard (locked == false) else {
      return
    }
    ContestInterface.setPlacementsOnly(eventId: self.eventId, placementOnly:value)
    CurrentContestItems.sharedInstance.placementOnly = value
  }
  
  // setInitialScoresDismissed
  // update score picks in FB DB
  func setScorePicks() {
    guard (locked == false) else {
      return
    }
    ContestInterface.setScorePicks(eventId: self.eventId, corpsScores:corpsScores)
  }
  
  // setInitialScoresDismissed
  // the user made a decision on initial scores
  func setInitialScoresDismissed() {
    ContestInterface.setInitialScoresDismissed(eventId: self.eventId)
    CurrentContestItems.sharedInstance.initialScoresDismissed = true
  }
  
  func sortCorpsScores(completion:@escaping () -> ()?) {
    let newCorpsScores:[CorpsScore] = self.corpsScores.sorted {
      ($0.score.pick as NSString).doubleValue > ($1.score.pick as NSString).doubleValue
    }
    self.updateScores(corpsScores: newCorpsScores)
    setScorePicks()
    completion()
  }
  
  // CurrentContestProtocol
  
  func updateLineup(lineup:Lineup) {
  }
  
  /// If this method is called, our contest has results
  /// This means that we should sort corpsScores to be parallel with them
  /// So we can display in order
  func updateResults(resultScores:[CorpsScore]) {
    var i = 0
    var newCorpsScores = self.corpsScores
    resultPickPlacements = []
    for cS1 in resultScores {
      var j = 0
      for cS2 in self.corpsScores {
        if (cS1.corps.name == cS2.corps.name) {
          print("\(i) \(j)")
          newCorpsScores[i] = self.corpsScores[j]
          resultPickPlacements.append(j)
        }
        j += 1
      }
      i += 1
    }
    self.corpsScores = newCorpsScores
    
    if let view = self.vc as? ContestView {
      view.reload()
    }
  }
  
  func updateScores(corpsScores:[CorpsScore]) {
    self.corpsScores = corpsScores
    if let view = self.vc as? ContestView {
      view.reload()
    }
  }
  
  func updateInitialScoresDismissed(initialScoresDismissed:Bool) {
    if let view = self.vc as? ContestView {
      view.reload()
    }
  }
  
  func updatePlacementOnly(placementOnly:Bool) {
    if let view = self.vc as? ContestView {
      view.reload()
    }
  }
  
}

