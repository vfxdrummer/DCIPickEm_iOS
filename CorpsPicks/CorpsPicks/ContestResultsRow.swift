//
//  ContestResultsRow.swift
//  Corps Picks
//
//  Created by Tim Brandt on 6/19/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//
//  USAGE : Displays Results of a Contest

import UIKit

class ContestResultsRow: UITableViewCell, UITextFieldDelegate {

  var corps : Corps? = nil
  var viewModel : CPViewModel? = nil
  var scoreGesture : UIPanGestureRecognizer? = nil
  var tapGesture : UITapGestureRecognizer? = nil
  var scoreDirection : Bool = true
  var index : Int = 0
  var madePicks : Bool = false
  var placementOnly : Bool = true
  var locked : Bool = false
  weak var contestView: ContestView?
  
  @IBOutlet var corpsPlacementResult: UILabel!
  @IBOutlet var corpsPlacementPick: UILabel!
  @IBOutlet var corpsName: UILabel!
  @IBOutlet var corpsImage: UIImageView!
  @IBOutlet var corpsScoreResult: UILabel!
  @IBOutlet var corpsScorePick: UILabel!
  
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
  func load(_ placementResult:Int, placementPick:Int, resultsScore:CorpsScore, corpsScore:CorpsScore, madePicks: Bool, placementOnly: Bool) {
    self.corpsName.text = resultsScore.corps.name
    self.corpsImage.fadeIn(resultsScore.corps.imageFileName)
    
    self.corpsPlacementResult.text = "\(placementResult)"
    self.corpsPlacementPick.text = "\(placementPick)"
    
    self.corpsScoreResult.text = resultsScore.score.pick
    self.corpsScorePick.text = corpsScore.score.pick
    
    self.madePicks = madePicks
    self.placementOnly = placementOnly
    
    updateVisibility()
  }
  
  // set visibility accouding to locked and placementOnly
  func updateVisibility() {
    switch (madePicks) {
    case true:
      corpsScorePick.isHidden = false
      corpsPlacementPick.isHidden = false
    case false:
      corpsScorePick.isHidden = true
      corpsPlacementPick.isHidden = true
      return
    }
    switch (placementOnly) {
    case true:
      corpsScorePick.isHidden = true
    case false:
      corpsScorePick.isHidden = false
    }
  }
  
}
