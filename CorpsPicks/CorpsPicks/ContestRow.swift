//
//  ContestRow.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 4/9/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//
//  USAGE: ContestRow is a UITableViewCell that appears only in the ArtistView

import UIKit

class ContestRow: UITableViewCell {

  var corps : Corps? = nil
  var viewModel : CPViewModel? = nil
  var scoreGesture : UIPanGestureRecognizer? = nil
  var tapGesture : UITapGestureRecognizer? = nil
  var scoreDirection : Bool = true
  var index : Int = 0
  weak var contestView: ContestView?
  
  @IBOutlet var corpsName: UILabel!
  @IBOutlet var corpsImage: UIImageView!
  @IBOutlet var corpsScore: UILabel!
  @IBOutlet var scorePanGestureView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  /**
   load
   Loads the album's name, subtitle, and cover image
   If is a local album, fetches the artwork from the Media Library
   viewModel is not assigned here and is assined in the ArtistView
   - parameter album: Album
   */
  func load(_ index:Int, corpsScore:CorpsScore) {
    self.index = index
    
    // TEMP HACK!!!!!!!
    corpsScore.corps.imageFileName = (index % 2) == 0 ? "bd1.jpg" : "crown1.jpg"
    
    self.corpsName.text = corpsScore.corps.name
    self.corpsScore.text = corpsScore.score.pick
    self.corpsImage.fadeIn(corpsScore.corps.imageFileName)
    
    self.scoreGesture = UIPanGestureRecognizer(target: self, action: #selector(ContestRow.handlePan(_:)))
    self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(ContestRow.handleTap(_:)))
    self.scorePanGestureView.addGestureRecognizer(self.scoreGesture!)
    self.scorePanGestureView.addGestureRecognizer(self.tapGesture!)
  }
  
  @IBAction func handlePan(_ recognizer:UIPanGestureRecognizer) {
    let translation = recognizer.translation(in: self.scorePanGestureView)
    var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!) + (translation.x / 100.0)
    corpsScoreFloat = (corpsScoreFloat <= 100) ? corpsScoreFloat : 100
    corpsScoreFloat = (corpsScoreFloat >= 0) ? corpsScoreFloat : 0
    self.scoreDirection = translation.x > 0.0 ? true : false
    let scoreText = String(format:"%.2f", corpsScoreFloat)
//    self.corpsScore.text = scoreText
    
    if (contestView != nil) { contestView!.updateCorpsScore(self.index, pickScore: scoreText) }
  }

  @IBAction func handleTap(_ recognizer:UIPanGestureRecognizer) {
    var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!)
    corpsScoreFloat = self.scoreDirection ? corpsScoreFloat + 0.01 : corpsScoreFloat - 0.01
    let scoreText = String(format:"%.2f", corpsScoreFloat)
//        self.corpsScore.text = scoreText
    
    if (contestView != nil) { contestView!.updateCorpsScore(self.index, pickScore: scoreText
      ) }
  }
  
}
