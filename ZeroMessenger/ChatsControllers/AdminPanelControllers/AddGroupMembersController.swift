//
//  AddGroupMembersController.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class AddGroupMembersController: SelectParticipantsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupRightBarButton(with: "Add")
    setupNavigationItemTitle(title: "Add users")
  }
  
  override func rightBarButtonTapped() {
    super.rightBarButtonTapped()
    
    addNewMembers()
  }
}
