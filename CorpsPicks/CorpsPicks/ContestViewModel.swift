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
      return [a]
    }
  }
  
  func setup() {
  }
}

