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
    var userScores : Dictionary<String, String> = [:]
    
    init(leaderboardDict: Dictionary<String, AnyObject>) {
        super.init()
        if let id = leaderboardDict["id"] {
            self.id = id as! String
        }
        if let userScores = leaderboardDict["userScores"] {
            self.userScores = userScores as! Dictionary<String, String>
        }
    }
}
