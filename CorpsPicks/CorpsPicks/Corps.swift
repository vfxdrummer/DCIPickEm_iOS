//
//  Corps.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class Corps : NSObject {
  var id : String = ""
  var name : String = ""
  var imageFileName : String = ""
  var logo_image_url : String = ""
  var logo_image_url_thumb : String = ""
  
  init(corpsDict: Dictionary<String, String>) {
    super.init()
    if let id = corpsDict["id"] {
      self.id = id
    }
    if let name = corpsDict["name"] {
      self.name = name
    }
  }
}
