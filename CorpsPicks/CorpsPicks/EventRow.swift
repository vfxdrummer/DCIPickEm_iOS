//
//  EventRow.swift
//  Earbits Radio
//
//  Created by Tim Brandt on 4/9/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
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
  @IBOutlet var eventImage: UIImageView!
  @IBOutlet var pickStatusImage: UIImageView!
  
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
    self.event = event
    self.eventName.text = event.name
    self.eventDate.text = event.date_label
    self.eventLocation.text = event.location
    self.setEventImage(event: event)
    
    // fetch pickStatus and update accordingly
    ContestInterface.getContestPickStatus(eventId: event.id, onSuccess: { [unowned self] in
      self.pickStatusImage.image = UIImage(named:"checkMark")?.maskWithColor(color: .green)
      }, onFailure: { [unowned self] in
        self.pickStatusImage.image = UIImage(named:"close")?.maskWithColor(color: .red)
    })
  }
  
  func setEventImage(event:Event) {
    var imageName = event.imageName
    if imageName == "" {
      let eventMinNum = 14
      let eventMaxNum = 38
      let randomEvent = Int(arc4random_uniform(UInt32(eventMaxNum - eventMinNum)) + 1) + eventMinNum
      imageName = "event\(randomEvent).jpg"
    }
    
    self.eventImage.image = UIImage(named:imageName)
    
    self.eventImage.subviews.forEach({ $0.removeFromSuperview() })
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.eventImage.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.alpha = 0.35
    self.eventImage.addSubview(blurEffectView)
  }
  
}
