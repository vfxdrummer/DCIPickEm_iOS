//
//  ContestOptionsRow.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 5/27/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//
//  USAGE: ContestOptionsRow is a UITableViewCell that appears only in the ArtistView

import UIKit

class ContestOptionsRow: UITableViewCell {
  
  weak var contestView: ContestView?

  @IBOutlet weak var contestOptionsSwitch: UISwitch!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  @IBAction func switchValueChanged(_ sender: UISwitch) {
    contestView?.contestOptionSwitchChanged(value: sender.isOn)
  }
  
}
