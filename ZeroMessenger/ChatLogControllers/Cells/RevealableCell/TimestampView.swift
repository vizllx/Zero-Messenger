//
//  TimestampView.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class TimestampView: RevealableView {

  @IBOutlet var titleLabel: UILabel!

  override init(frame: CGRect) {
    super.init(frame: frame)

    titleLabel.textColor = ThemeManager.currentTheme().generalSubtitleColor
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
}
