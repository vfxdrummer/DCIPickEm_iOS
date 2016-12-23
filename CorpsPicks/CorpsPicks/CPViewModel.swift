//
//  CPViewModel.swift
//  Earbits Radio
//
//  Created by James Tan on 5/14/16.
//  Copyright © 2016 Earbits. All rights reserved.
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
