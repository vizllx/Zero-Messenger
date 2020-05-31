//
//  OnboardingController.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class OnboardingController: UIViewController {

  let onboardingContainerView = OnboardingContainerView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(red: 37.0/255.0, green: 37.0/255.0, blue: 37.0/255.0, alpha: 1.0)
    view.addSubview(onboardingContainerView)
    onboardingContainerView.frame = view.bounds
    setColorsAccordingToTheme()
  }
  
  fileprivate func setColorsAccordingToTheme() {
    let theme = ThemeManager.currentTheme()
    ThemeManager.applyTheme(theme: theme)
    view.backgroundColor = UIColor(red: 37.0/255.0, green: 37.0/255.0, blue: 37.0/255.0, alpha: 1.0)
    onboardingContainerView.backgroundColor = view.backgroundColor
  }
  
  @objc func startMessagingDidTap () {
    let destination = AuthPhoneNumberController()
    navigationController?.pushViewController(destination, animated: true)
  }

}
