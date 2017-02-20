//
//  CorpsScore.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class CorpsScore : NSObject {
  var corps : Corps = Corps(corpsString: "")
  var score : Score = Score(score: "")
  
  init(corps: Corps, score : Score) {
    self.corps = corps
    self.score = score
  }
}
