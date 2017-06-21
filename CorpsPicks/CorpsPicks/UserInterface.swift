//
//  UserInterface.swift
//  UserPicks
//
//  Created by Timothy Brandt on 2/18/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseDatabase

class UserInterface: NSObject {
  class func setUser() {
    // move this to singleton, set on Auth
    let userId = CurrentUser.sharedInstance.uid
    let email = CurrentUser.sharedInstance.email
    let photoURL = CurrentUser.sharedInstance.photoURL
    
    let ref = Database.database().reference()
    
    let usersRef = ref.child("2017/v1//users")
    let userRef = usersRef.child("/\(userId)")
    userRef.child("email").setValue(email)
    userRef.child("photoURL").setValue(photoURL)
  }
  
  /**
   getUserById
   Get User from CurrentUserItems using UserId
   */
  class func getUserById(userId:String, onSuccess:@escaping (CPUser)->()) {
    let ref = Database.database().reference()
      
    ref.child("2017/v1/users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
      let user = CPUser()
      user.uid = userId
      onSuccess(user)
    })
  }
}
