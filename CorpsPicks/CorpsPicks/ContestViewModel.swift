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
      let b : Corps = Corps()
      b.name = "Bluecoats"
      let c : Corps = Corps()
      c.name = "Crown"
      let d : Corps = Corps()
      d.name = "Cadets"
      let e : Corps = Corps()
      e.name = "Cavaliers"
      return [a, b, c, d, e]
    }
  }
  
  func setup() {
  }
}

