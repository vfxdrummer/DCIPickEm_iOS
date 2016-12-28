//
//  ContestRow.swift
//  Earbits Radio
//
//  Created by James Tan on 4/29/16.
//  Copyright © 2016 Earbits. All rights reserved.
//
//  USAGE: ContestRow is a UITableViewCell that appears only in the ArtistView

import UIKit

class ContestRow: UITableViewCell {

  var corps : Corps? = nil
  var viewModel : CPViewModel? = nil
  var scoreGesture : UIPanGestureRecognizer? = nil
  var tapGesture : UITapGestureRecognizer? = nil
  var scoreDirection : Bool = true
  
  @IBOutlet var corpsName: UILabel!
  @IBOutlet var corpsImage: UIImageView!
  @IBOutlet var corpsScore: UILabel!
  @IBOutlet var scorePanGestureView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  /**
   load
   Loads the album's name, subtitle, and cover image
   If is a local album, fetches the artwork from the Media Library
   viewModel is not assigned here and is assined in the ArtistView
   - parameter album: Album
   */
  func load(corps:Corps) {
    self.corpsName.text = corps.name
    self.corpsScore.text = corps.score
    self.corpsImage.fadeIn(corps.imageFileName)
    
    self.scoreGesture = UIPanGestureRecognizer(target: self, action: #selector(ContestRow.handlePan(_:)))
    self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(ContestRow.handleTap(_:)))
    self.addGestureRecognizer(self.scoreGesture!)
    self.addGestureRecognizer(self.tapGesture!)
  }
  
  @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
    let translation = recognizer.translationInView(self.scorePanGestureView)
    var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!) + (translation.x / 100.0)
    corpsScoreFloat = (corpsScoreFloat <= 100) ? corpsScoreFloat : 100
    corpsScoreFloat = (corpsScoreFloat >= 0) ? corpsScoreFloat : 0
    self.scoreDirection = translation.x > 0.0 ? true : false
    self.corpsScore.text = String(format:"%.2f", corpsScoreFloat)
    print(translation.x / 100.0)
//    if recognizer.state == UIGestureRecognizerState.Ended {
//      let velocity = recognizer.velocityInView(self.scorePanGestureView)
//      var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!) + (velocity.x / 100.0)
//      corpsScoreFloat = (corpsScoreFloat <= 100) ? corpsScoreFloat : 100
//      corpsScoreFloat = (corpsScoreFloat >= 0) ? corpsScoreFloat : 0
//      self.corpsScore.text = String(format:"%.2f", corpsScoreFloat)
//      print(velocity.x / 100.0)
//    }
  }

  @IBAction func handleTap(recognizer:UIPanGestureRecognizer) {
    var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!)
    corpsScoreFloat = self.scoreDirection ? corpsScoreFloat + 0.01 : corpsScoreFloat - 0.01
    self.corpsScore.text = String(format:"%.2f", corpsScoreFloat)
  }
  
}
