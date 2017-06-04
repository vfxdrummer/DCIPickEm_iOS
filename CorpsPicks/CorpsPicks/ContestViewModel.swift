//
//  ContestViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestViewModel: CPViewModel, CurrentContestProtocol {
  
  public var lineup : Lineup {
    get {
      return CurrentContestItems.sharedInstance.lineup!
    }
  }

  public var corpsScores : [CorpsScore] = []
  private var lastEventId : String? = nil
  public var eventId : String? = nil {
    didSet {
      guard(eventId != nil && lastEventId != nil) else {
        return
      }
      if (eventId! != lastEventId!) {
        print("corpsScores.eventId didSet, eventId=\(eventId!), lastEventId=\(lastEventId!) : loadLineup()")
        loadLineup()
      }
      lastEventId = eventId
    }
  }
  
  var initialScoresDismissed : Bool {
    get {
      return CurrentContestItems.sharedInstance.initialScoresDismissed
    }
  }
  
  func setup(eventId:String) {
    self.eventId = eventId
    CurrentContestItems.sharedInstance.delegate = self
  }
  
  func loadLineup() {
    guard (eventId != nil) else { return }
    print("ContestVM : loadLineup")
    ContestInterface.getLineup(eventId:eventId!)
    ContestInterface.getScorePicks(eventId:eventId!)
  }
  
  // setInitialScores
  // set corpsPicks using initial scores
  func setInitialScores() {
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
  
  
  // setInitialScoresDismissed
  // update score picks in FB DB
  func setScorePicks() {
    guard (self.eventId != nil) else { return }
    ContestInterface.setScorePicks(eventId: self.eventId!, corpsScores:corpsScores)
  }
  
  // setInitialScoresDismissed
  // the user made a decision on initial scores
  func setInitialScoresDismissed() {
    guard (self.eventId != nil) else { return }
    ContestInterface.setInitialScoresDismissed(eventId: self.eventId!)
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
    if let view = self.vc as? ContestView {
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
  
}

