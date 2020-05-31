//
//  SelectGroupMembersController.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit


class SelectGroupMembersController: SelectParticipantsViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupRightBarButton(with: "Next")
    setupNavigationItemTitle(title: "New group")
  }
  
  override func rightBarButtonTapped() {
    super.rightBarButtonTapped()
    
    createGroup()
  }
}
