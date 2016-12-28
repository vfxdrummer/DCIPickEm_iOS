//
//  CorpsScores.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class CorpsScores : NSObject {
  var corps : [Corps] = []
  
  private func sortCorpsByScore(corps1: Corps, corps2: Corps) -> Bool {
    return Double(corps1.score) < Double(corps2.score)
  }
  
  func sort() {
    self.corps.sortInPlace {
      return sortCorpsByScore($0, corps2: $1)
    }
  }
}