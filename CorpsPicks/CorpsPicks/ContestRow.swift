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
  
//  @IBOutlet var subName: UILabel!
//  @IBOutlet var albumName: UILabel!
//  @IBOutlet var coverImage: UIImageView!
  
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
  }
}
