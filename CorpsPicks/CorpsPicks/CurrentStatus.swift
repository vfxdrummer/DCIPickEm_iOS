//
//  CPViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 2/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit

//  MARK: CurrentLeaderboardItems
protocol CurrentEventProtocol {
  func updateEvents(events:[Event])
}
class CurrentEventItems : NSObject {
  static let sharedInstance = CurrentEventItems()
  private var delegates : [CurrentEventProtocol] = []
  
  var delegate : CurrentEventProtocol? = nil {
    didSet {
      delegates.append(delegate!)
    }
  }
  var events : [Event] = [] {
    didSet {
      _ = delegates.map({
        $0.updateEvents(events: events)
      })
    }
  }
}

