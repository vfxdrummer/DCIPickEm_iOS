//
//  Score.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class Score : NSObject {
  var pick : String = ""
  var lastScore : String = ""
  var lastScoreDate : String = ""
  
  init(score: String) {
    self.pick = score
  }
}