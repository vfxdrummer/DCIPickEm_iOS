//
//  CorpsInterface.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 2/24/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseDatabase

class CorpsInterface: NSObject {
  
  /**
   getCorps
   Get Corps list from Firebase DB
   */
  class func getCorps() {
    let ref = Database.database().reference()
    let eventsRef = ref.child("corps")
    eventsRef.observe(.value, with: { snapshot in
      var corpsDict:[String:Corps] = [:]
      for _ in snapshot.children {
        for corps in snapshot.children.allObjects as! [DataSnapshot] {
          guard let corpsDictNew = corps.value as? [String: AnyObject] else {
            continue
          }
          let corps = Corps(corpsDict: corpsDictNew as! Dictionary<String, String>)
          corpsDict[corps.name] = corps
        }
      }
      CurrentCorpsItems.sharedInstance.corps = corpsDict
    }) { (error) in
      print(error.localizedDescription)
    }
  }
  
  /**
   getCorpsById
   Get Corps from CurrentCorpsItems using corpsId
   */
  class func getCorpsById(corpsId:String) -> Corps {
    let corpsDict:[String:Corps] = CurrentCorpsItems.sharedInstance.corps
    if (corpsDict[corpsId] != nil) {
      return corpsDict[corpsId]!
    }
    // we need to return a default corps
    return corpsDict.values.first!
  }
  
}
