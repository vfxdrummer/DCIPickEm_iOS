//
//  ExtUIViewController.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 5/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  func hideKeyboardRecognizer()
  {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard))
    
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard()
  {
    view.endEditing(true)
  }
  
}
