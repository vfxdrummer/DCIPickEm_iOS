//
//  CorpsScores.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class ContestPick : NSObject {
  var corpsScores : [CorpsScore] = []
  
  fileprivate func sortCorpsByScore(_ corpsScore1: Score, corpsScore2: Score) -> Bool {
    return Double(corpsScore1.pick) < Double(corpsScore2.pick)
  }
  
  func sort() {
    self.corpsScores.sort {
      return sortCorpsByScore($0.score, corpsScore2: $1.score)
    }
  }
}
