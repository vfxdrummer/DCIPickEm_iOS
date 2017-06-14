//
//  Corps.swift
//  CorpsPicks
//
//  Created by Tim Brandt on 12/23/16.
//  Copyright © 2016 Tim Brandt. All rights reserved.
//

import UIKit

class Corps : NSObject {
  var slug : String = ""
  var name : String = ""
  var lastScore : String = "0.0"
  var imageFileName : String = ""
  var logo_image_url : String = ""
  var logo_image_url_thumb : String = ""
  
  init(corpsDict: Dictionary<String, String>) {
    super.init()
    if let name = corpsDict["name"] {
      self.name = name
      self.slug = slugNameFromCorpsName(corpsName: name)
    }
    if let lastScore = corpsDict["lastScore"] {
      if let n = NumberFormatter().number(from: lastScore) {
        self.lastScore = CGFloat(n).description
      }
    }
    
    self.imageFileName = "\(self.slug)1.jpg"
  }
  
  // temp hack until we're using slug names
  func slugNameFromCorpsName(corpsName: String) -> String {
    switch(corpsName) {
    case "North Star":
      return "7thregiment"
    case "The Muchachos":
      return "7thregiment"
    case "7th Regiment":
      return "7thregiment"
    case "Blue Devils B":
      return "bluedevilsb"
    case "Blue Devils C":
      return "bluedevilsc"
    case "Colt Cadets":
      return "coltcadets"
    case "Columbians":
      return "columbians"
    case "Heat Wave":
      return "heatwave"
    case "Impulse":
      return "impulse"
    case "Incognito":
      return "incognito"
    case "Legends":
      return "legends"
    case "Lessentor":
      return "lessentor"
    case "Louisiana Stars":
      return "louisianastars"
    case "Music City":
      return "musiccity"
    case "Raiders":
      return "raiders"
    case "River City Rhythm":
      return "rivercityryhthm"
    case "Shadow":
      return "shadow"
    case "Southwind":
      return "southwind"
    case "Spartans":
      return "spartans"
    case "The Battalion":
      return "thebattalion"
    case "Vanguard Cadets":
      return "vanguardcadets"
    case "Watchmen":
      return "watchmen"
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
