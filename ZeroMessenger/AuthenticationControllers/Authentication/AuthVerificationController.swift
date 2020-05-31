//
//  AuthVerificationController.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 3/30/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit


class AuthVerificationController: EnterVerificationCodeController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setRightBarButton(with: "Next")
  }
  
  override func rightBarButtonDidTap() {
    super.rightBarButtonDidTap()
    authenticate()
  }
}
