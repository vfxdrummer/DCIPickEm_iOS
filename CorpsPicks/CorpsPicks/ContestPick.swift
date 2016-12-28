//
//  CorpsScores.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestPick : NSObject {
  var corpsScores : [CorpsScore] = []
  
  private func sortCorpsByScore(corpsScore1: Score, corpsScore2: Score) -> Bool {
    return Double(corpsScore1.pick) < Double(corpsScore2.pick)
  }
  
  func sort() {
    self.corpsScores.sortInPlace {
      return sortCorpsByScore($0.score, corpsScore2: $1.score)
    }
  }
}