//
//  ContestViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestViewModel: CPViewModel, CurrentContestProtocol {
  
  var contest : Contest? = nil
  var corpsScores : [CorpsScore] = []
  
  func setup() {
    CurrentContestItems.sharedInstance.delegate = self
//    let a : Corps = Corps()
//    a.name = "Blue Devils"
//    a.imageFileName = "bluedevils.png"
//    let aS : Score = Score(score: "97.3")
//    let aCS : CorpsScore = CorpsScore(corps: a, score: aS)
//    
//    let b : Corps = Corps()
//    b.name = "Bluecoats"
//    b.imageFileName = "bluecoats.jpeg"
//    let bS : Score = Score(score: "96.9")
//    let bCS : CorpsScore = CorpsScore(corps: b, score: bS)
//    
//    let c : Corps = Corps()
//    c.name = "Crown"
//    c.imageFileName = "crown2.jpg"
//    let cS : Score = Score(score: "96.7")
//    let cCS : CorpsScore = CorpsScore(corps: c, score: cS)
//    
//    let d : Corps = Corps()
//    d.name = "Cadets"
//    d.imageFileName = "cadets.jpeg"
//    let dS : Score = Score(score: "94.5")
//    let dCS : CorpsScore = CorpsScore(corps: d, score: dS)
//    
//    let e : Corps = Corps()
//    e.name = "Cavaliers"
//    e.imageFileName = "cavaliers.jpeg"
//    let eS : Score = Score(score: "94.2")
//    let eCS : CorpsScore = CorpsScore(corps: e, score: eS)
//    
////    _ : ContestPick = ContestPick()
//    self.corpsScores = [aCS, bCS, cCS, dCS, eCS]
////    self.contestPick = contestPick
  }
  
  func loadContest(eventId: String) {
    ContestInterface.getContest(eventId: eventId)
  }
  
  func sort() {
    self.corpsScores.sort { $0.score.pick > $1.score.pick }
  }
  
  func updateContest(contest:Contest){
    if let view = self.vc as? ContestView {
      view.loadContest(contest: contest)
    }
  }
  
}

