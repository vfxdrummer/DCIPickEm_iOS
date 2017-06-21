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
  
  init(leaderboardDict: Dictionary<String, AnyObject>, onSuccess:@escaping (Leaderboard)->()) {
    super.init()
    let scoreArray = Array(leaderboardDict.keys)
    _ = scoreArray.map({
      print($0)
      print(leaderboardDict[$0]!)
      let userLocal = CPUser()
      userLocal.uid = $0.replacingOccurrences(of: "\"", with: "", options: .literal, range: nil)
      UserInterface.getUserById(userId: userLocal.uid, onSuccess: { user in
        userLocal.name = user.name
        self.userScores.append(UserScore.init(user: userLocal, score: leaderboardDict[userLocal.uid]! as! String))
        print(self.userScores)
        onSuccess(self)
      })
    })
  }
}
