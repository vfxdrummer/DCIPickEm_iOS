//
//  ContestViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestViewModel: CPViewModel, CurrentContestProtocol {
  
  var lineup : Lineup {
    get {
      return CurrentContestItems.sharedInstance.lineup!
    }
  }

  var corpsScores : [CorpsScore] = []
  var eventId : String? = nil
  
  func setup(eventId:String) {
    self.eventId = eventId
    CurrentContestItems.sharedInstance.delegate = self
  }
  
  func loadLineup() {
    guard (eventId != nil) else { return }
    ContestInterface.getLineup(eventId:eventId!)
    ContestInterface.getScorePicks(eventId:eventId!)
  }
  
  func setScorePicks() {
    guard (eventId != nil) else { return }
    ContestInterface.setScorePicks(eventId: eventId!, corpsScores:corpsScores)
  }
  
  func sortCorpsScores() {
    let newCorpsScores:[CorpsScore] = self.corpsScores.sorted {
      ($0.score.pick as NSString).doubleValue > ($1.score.pick as NSString).doubleValue
    }
    self.updateScores(corpsScores: newCorpsScores)
    print("sorted :")
    for corpsScore in newCorpsScores {
      print("\(corpsScore.corps.name) \(corpsScore.score.pick)")
    }
    setScorePicks()
  }
  
  // CurrentContestProtocol
  
  func updateLineup(lineup:Lineup) {
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
  
}

