//
//  ContestRow.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 4/9/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//
//  USAGE: ContestRow is a UITableViewCell that appears only in the ArtistView

import UIKit

class ContestRow: UITableViewCell, UITextFieldDelegate {

  var corps : Corps? = nil
  var viewModel : CPViewModel? = nil
  var scoreGesture : UIPanGestureRecognizer? = nil
  var tapGesture : UITapGestureRecognizer? = nil
  var scoreDirection : Bool = true
  var index : Int = 0
  var placementOnly : Bool = true
  var locked : Bool = false
  weak var contestView: ContestView?
  
  @IBOutlet var corpsName: UILabel!
  @IBOutlet var corpsImage: UIImageView!
  @IBOutlet var corpsScore: UILabel!
  @IBOutlet var scorePanGestureView: UIImageView!
  @IBOutlet weak var scoreEntryField: UITextField!
  
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
  func load(_ index:Int, corpsScore:CorpsScore, placementOnly: Bool, locked: Bool) {
    self.index = index
    
    self.corpsName.text = corpsScore.corps.name
    self.corpsScore.text = corpsScore.score.pick
    self.scoreEntryField.text = corpsScore.score.pick
    self.corpsImage.fadeIn(corpsScore.corps.imageFileName)
    self.placementOnly = placementOnly
    self.locked = locked
    
    // setup scoreEntryField
    self.scoreEntryField.delegate = self
    self.scoreEntryField.becomeFirstResponder()
    self.scoreEntryField.keyboardType = UIKeyboardType.numbersAndPunctuation
    
    // HIDE score label for now
    self.corpsScore.isHidden = true
    
    self.scoreGesture = UIPanGestureRecognizer(target: self, action: #selector(ContestRow.handlePan(_:)))
    self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(ContestRow.handleTap(_:)))
    self.scorePanGestureView.addGestureRecognizer(self.scoreGesture!)
    self.scorePanGestureView.addGestureRecognizer(self.tapGesture!)
    
    updateVisibility()
    
    scoreEntryField.resignFirstResponder()
  }
  
  private func updateCorpsScore(scoreText:String) {
    if (contestView != nil) { contestView!.updateCorpsScore(self.index, pickScore: scoreText
      ) }
  }
  
  // set visibility accouding to locked and placementOnly
  func updateVisibility() {
    switch (self.locked) {
    case true:
      scorePanGestureView.isHidden =  true
      scoreEntryField.isHidden =      self.placementOnly
      scoreEntryField.isEnabled =     false
      corpsScore.isHidden =           true
    case false:
      scorePanGestureView.isHidden =  self.placementOnly
      scoreEntryField.isHidden =      self.placementOnly
      scoreEntryField.isEnabled =     true
      corpsScore.isHidden =           true
    }
  }
  
  @IBAction func handlePan(_ recognizer:UIPanGestureRecognizer) {
    let translation = recognizer.translation(in: self.scorePanGestureView)
    var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!) + (translation.x / 100.0)
    corpsScoreFloat = (corpsScoreFloat <= 100) ? corpsScoreFloat : 100
    corpsScoreFloat = (corpsScoreFloat >= 0) ? corpsScoreFloat : 0
    self.scoreDirection = translation.x > 0.0 ? true : false
    let scoreText = String(format:"%.2f", corpsScoreFloat)
    
    updateCorpsScore(scoreText:scoreText)
  }

  @IBAction func handleTap(_ recognizer:UIPanGestureRecognizer) {
    var corpsScoreFloat = CGFloat(Double(self.corpsScore.text!)!)
    corpsScoreFloat = self.scoreDirection ? corpsScoreFloat + 0.01 : corpsScoreFloat - 0.01
    let scoreText = String(format:"%.2f", corpsScoreFloat)
    updateCorpsScore(scoreText:scoreText)
  }
  
  // Mark - UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    guard (textField.text != nil) else {
      return true
    }
    updateCorpsScore(scoreText:textField.text!)
    return true
  }
  
}
