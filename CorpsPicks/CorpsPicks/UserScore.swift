//
//  UserScore.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 4/11/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class UserScore : NSObject {
  var user : CPUser = CPUser()
  var placement : String
  var score : String
  
  init(user: CPUser, score: String, placement: String) {
    self.user = user
    self.score = score
    self.placement = placement
  }
}
