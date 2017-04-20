//
//  UserScore.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 4/11/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class UserScore : NSObject {
  var user : User = User()
  var score : String
  
  init(user: User, score : String) {
    self.user = user
    self.score = score
  }
}
