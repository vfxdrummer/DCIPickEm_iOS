//
//  LeaderboardRow.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 4/9/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//
//  USAGE: LeaderboardRow is a UITableViewCell that appears only in the ArtistView

import UIKit

class LeaderboardRow: UITableViewCell {

  var corps : Corps? = nil
  var viewModel : CPViewModel? = nil
  var scoreGesture : UIPanGestureRecognizer? = nil
  var tapGesture : UITapGestureRecognizer? = nil
  var scoreDirection : Bool = true
  var index : Int = 0
  weak var leaderboardView: LeaderboardView?
    
  @IBOutlet var userPlacement: UILabel!
  @IBOutlet var userName: UILabel!
  @IBOutlet var userScore: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  /**
   load the UserScore
   - parameter album: Album
   */
  func load(_ index:Int, userScore:UserScore) {
    self.index = index
    self.userName.text = userScore.user.name
    self.userScore.text = userScore.score
  }
}
