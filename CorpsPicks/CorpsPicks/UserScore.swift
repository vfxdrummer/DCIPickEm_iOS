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
  var placement : Int?
  var score : String
  
  init(user: CPUser, score : String) {
    self.user = user
    self.score = score
  }
}
