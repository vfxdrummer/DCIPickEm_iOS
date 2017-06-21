//
//  Leaderboard.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 4/9/17.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class Leaderboard : NSObject {
  var id : String = ""
  var userScores : [UserScore] = []
  
  init(leaderboardDict: Dictionary<String, AnyObject>) {
    super.init()
    let scoreArray = Array(leaderboardDict.keys)
    _ = scoreArray.map({
      print($0)
      print(leaderboardDict[$0]!)
      let user = CPUser()
      user.uid = $0
      user.name = $0
      userScores.append(UserScore.init(user: user, score: leaderboardDict[$0]! as! String))
      print(self.userScores)
    })
  }
}
