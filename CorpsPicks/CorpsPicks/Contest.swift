//
//  Contest.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class Contest : NSObject {
  var id : String = ""
  var name : String = ""
  var date : NSDate? = nil
  var lineup : [Int : Corps] = [:]
  var scores : [Corps : Float] = [:]
}


