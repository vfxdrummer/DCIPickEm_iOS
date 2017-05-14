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
  var slug : String = ""
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
      self.slug = slugNameFromCorpsName(corpsName: name)
    }
    
    self.imageFileName = "\(self.slug)1.jpg"
  }
  
  // temp hack until we're using slug names
  func slugNameFromCorpsName(corpsName: String) -> String {
    switch(corpsName) {
    case "The Academy":
      return "academy"
    case "Bluecoats":
      return "bluecoats"
    case "Blue Devils":
      return "bluedevils"
    case "Blue Knights":
      return "blueknights"
    case "Blue Stars":
      return "bluestars"
    case "Boston Crusaders":
      return "bostoncrusaders"
    case "The Cadets":
      return "cadets"
    case "Seattle Cascades":
      return "cascades"
    case "The Cavaliers":
      return "cavaliers"
    case "Colts":
      return "colts"
    case "Crossmen":
      return "crossmen"
    case "Carolina Crown":
      return "crown"
    case "Genesis":
      return "genesis"
    case "Jersey Surf":
      return "jerseysurf"
    case "Madison Scouts":
      return "madison"
    case "Mandarins":
      return "mandarins"
    case "Oregon Crusaders":
      return "oregoncrusaders"
    case "Pacific Crest":
      return "pacificcrest"
    case "Phantom Regiment":
      return "phantomregiment"
    case "Pioneer":
      return "pioneer"
    case "Spirit of Atlanta":
      return "spiritofatlanta"
    case "Troopers":
      return "troopers"
    case "Santa Clara Vanguard":
      return "vanguard"
    default:
      return "vanguard"
    }
  }
}
