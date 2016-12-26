//
//  ContestViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class ContestViewModel: CPViewModel {
  
  var corps : [Corps] {
    get {
      let a : Corps = Corps()
      a.name = "Blue Devils"
      a.score = "97.3"
      let b : Corps = Corps()
      b.name = "Bluecoats"
      b.score = "96.9"
      let c : Corps = Corps()
      c.name = "Crown"
      c.score = "96.7"
      let d : Corps = Corps()
      d.name = "Cadets"
      d.score = "94.5"
      let e : Corps = Corps()
      e.name = "Cavaliers"
      e.score = "94.2"
      return [a, b, c, d, e]
    }
  }
  
  func setup() {
  }
}

