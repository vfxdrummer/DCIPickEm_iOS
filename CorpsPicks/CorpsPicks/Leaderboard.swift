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
    let userArray = Array(leaderboardDict.keys)
    _ = userArray.enumerated().map({ (index, element) in
      let userId = element
      guard let userScoreDict = leaderboardDict[userId] as? [String:String] else {
        return
      }
      let userLocal = CPUser()
      UserInterface.getUserById(userId: userId, onSuccess: { user in
        userLocal.name = user.name
        userLocal.email = user.email
        userLocal.uid = user.uid
        self.userScores.append(UserScore.init(user: userLocal, score: userScoreDict["score"]!, placement: userScoreDict["placement"]!))
        self.userScores = self.userScores.sorted {
          ($0.placement as NSString).doubleValue < ($1.placement as NSString).doubleValue
        }
        // Call Success Block on last index in .map
        if (index+1 >= userArray.count) {
          onSuccess(self)
        }
      }, onFailure: {
//        print("FAIL : \($0)")
      })
    })
  }
}
