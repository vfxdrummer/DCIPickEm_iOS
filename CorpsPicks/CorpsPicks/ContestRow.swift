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
    self.addGestureRecognizer(self.scoreGesture!)
  }
  
  @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
    let translation = recognizer.translationInView(self.scorePanGestureView)
    var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!) + (translation.x / 100.0)
    corpsScoreFloat = (corpsScoreFloat <= 100) ? corpsScoreFloat : 100
    corpsScoreFloat = (corpsScoreFloat >= 0) ? corpsScoreFloat : 0
    self.corpsScore.text = String(format:"%.2f", corpsScoreFloat)
    print(translation.x / 100.0)
  }
  
  
  
}
