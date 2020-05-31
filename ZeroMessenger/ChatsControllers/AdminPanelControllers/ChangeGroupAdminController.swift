//
//  ChangeGroupAdminController.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class ChangeGroupAdminController: SelectNewAdminTableViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRightBarButton(with: "Change administrator")
  }
  
  override func rightBarButtonTapped() {
    super.rightBarButtonTapped()
    setNewAdmin(membersIDs: getMembersIDs())
  }
}
