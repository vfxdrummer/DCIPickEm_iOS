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
  weak var leaderboardView: LeaderboardView?
    
  @IBOutlet weak var leaderboardImage: UIImageView!
  @IBOutlet var userPlacementLabel: UILabel!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var userScoreLabel: UILabel!
  
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
  func load(userScore:UserScore) {
    userPlacementLabel.text = userScore.placement != nil ? "\(userScore.placement)" : ""
    userNameLabel.text = userScore.user.name
    if let userScoreDouble = Double(userScore.score) {
        self.userScoreLabel.text = String(format: "%.2f", userScoreDouble)
    }
    self.setLeaderboardImage()
  }
  
  func setLeaderboardImage() {
    let eventMinNum = 0
    let eventMaxNum = 42
    let randomEvent = Int(arc4random_uniform(UInt32(eventMaxNum - eventMinNum)) + 1) + eventMinNum
    let imageName = randomEvent > 0 ? "leaderboard\(randomEvent).jpg" : "leaderboard.jpg"
    
    self.leaderboardImage.image = UIImage(named:imageName)
    
    self.leaderboardImage.subviews.forEach({ $0.removeFromSuperview() })
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.leaderboardImage.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.alpha = 0.35
    self.leaderboardImage.addSubview(blurEffectView)
  }
}
