//
//  User.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class User : NSObject {
  var uid : String = ""
  var name : String = ""
  var email : String = ""
  var photoURL : URL?
  
  override init() {
    
  }
  
  convenience init(uid:String, name:String, email:String, photoURL:URL?) {
    self.init()
    self.uid = uid
    self.name = name
    self.email = email
    self.photoURL = photoURL
  }
}
