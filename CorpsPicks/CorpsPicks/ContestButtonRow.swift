//
//  ContestButtonRow.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 5/27/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//
//  USAGE: ContestButtonRow is a UITableViewCell that appears only in the ArtistView

import UIKit

class ContestButtonRow: UITableViewCell, UITextFieldDelegate {
  
  weak var contestView: ContestView?
    
  @IBOutlet weak var setInitialScoresButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func initialScoresButtonPressed(_ sender: Any) {
    contestView?.pressedInitialScores()
  }
  
}
