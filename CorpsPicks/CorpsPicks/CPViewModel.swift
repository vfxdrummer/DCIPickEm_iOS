//
//  CPViewModel.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class CPViewModel : NSObject {
  weak var vc : UIViewController? = nil
  
  convenience override init() {
    self.init(viewController : nil)
  }
  
  init(viewController : UIViewController?) {
    self.vc = viewController
    super.init()
  }

  // Called on Accessory Views
  func dismiss() {
    if let v = self.vc as? ContestView {
      v.dismiss()
    }
  }
}
