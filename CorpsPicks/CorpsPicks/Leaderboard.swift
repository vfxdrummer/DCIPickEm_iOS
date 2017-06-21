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
      let userLocal = CPUser()
      userLocal.uid = $0
      UserInterface.getUserById(userId: $0, onSuccess: { user in
        userLocal.name = user.name
        self.userScores.append(UserScore.init(user: userLocal, score: leaderboardDict[userLocal.uid]! as! String))
        print(self.userScores)
      })
    })
  }
}
