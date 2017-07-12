//
//  EventSectionView.swift
//  CorpsPicks
//
//  Created by Timothy Brandt on 7/11/17.
//  Copyright © 2017 Tim Brandt. All rights reserved.
//

import UIKit

class EventSectionView: UIView {
  @IBOutlet weak var titleLabel: UILabel!
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
