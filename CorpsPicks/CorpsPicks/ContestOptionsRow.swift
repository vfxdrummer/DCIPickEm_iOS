//
//  ContestOptionsRow.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 5/27/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//
//  USAGE: ContestOptionsRow is a UITableViewCell that appears only in the ArtistView

import UIKit
import M13Checkbox

class ContestOptionsRow: UITableViewCell {
  
  weak var contestView: ContestView?

  @IBOutlet weak var placementsOnlyCheckBox: M13Checkbox!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // M13 checkbox initialization
  private func initializeCheckBox() {
    // values to return based on state
    placementsOnlyCheckBox.checkedValue = 1.0
    placementsOnlyCheckBox.uncheckedValue = 0.0
    
    // Update the animation duration
    placementsOnlyCheckBox.animationDuration = 0.3
    
    // Change the animation used when switching between states.
    placementsOnlyCheckBox.stateChangeAnimation = .stroke
    
    // Whether or not to display a checkmark, or radio mark.
    placementsOnlyCheckBox.markType = .checkmark
    // The line width of the checkmark.
    placementsOnlyCheckBox.checkmarkLineWidth = 2.0
    
    // The line width of the box.
    placementsOnlyCheckBox.boxLineWidth = 2.0
    // The corner radius of the box if it is a square.
    placementsOnlyCheckBox.cornerRadius = 4.0
    // Whether the box is a square, or circle.
    placementsOnlyCheckBox.boxType = .circle
    // Whether or not to hide the box.
    placementsOnlyCheckBox.hideBox = false
    
    // The background color of the view.
//    placementsOnlyCheckBox.backgroundColor = .white
    // The tint color when in the selected state.
    placementsOnlyCheckBox.tintColor = .white
    // The tint color when in the unselected state.
    placementsOnlyCheckBox.secondaryTintColor = .gray
    // The color of the checkmark when the animation is a "fill" style animation.
    placementsOnlyCheckBox.secondaryCheckmarkTintColor = .red
  }
  
  /**
   load
   */
  func load(_ placementOnly: Bool) {
    initializeCheckBox()
    
    switch (placementOnly) {
    case true:
      placementsOnlyCheckBox.setCheckState(.checked, animated: false)
    case false:
      placementsOnlyCheckBox.setCheckState(.unchecked, animated: false)
    }
  }
  
  @IBAction func placementOnlyCheckBoxValueChanged(_ sender: M13Checkbox) {
    var checkOn: Bool = false
    if (sender.checkState == .checked) {
      checkOn = true
    }
    contestView?.contestOptionSwitchChanged(value: checkOn)
  }
  
  
}
