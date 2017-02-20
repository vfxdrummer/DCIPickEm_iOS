//
//  EventRow.swift
//  Earbits Radio
//
//  Created by James Tan on 4/29/16.
//  Copyright © 2016 Earbits. All rights reserved.
//
//  USAGE: EventRow is a UITableViewCell that appears only in the ArtistView

import UIKit

class EventRow: UITableViewCell {

  var event : Event? = nil
  weak var eventView: EventView?
  var index : Int = 0
  
  @IBOutlet var eventName: UILabel!
  @IBOutlet var eventDate: UILabel!
  @IBOutlet var eventLocation: UILabel!
  
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
  func load(_ index:Int, event:Event) {
    self.index = index
    self.eventName.text = event.name
    self.eventDate.text = event.date_label
    self.eventLocation.text = event.location
  }
  
}
