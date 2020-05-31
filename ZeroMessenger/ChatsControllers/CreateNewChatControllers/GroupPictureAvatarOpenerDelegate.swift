//
//  GroupPictureAvatarOpenerDelegate.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

extension GroupProfileTableViewController: AvatarOpenerDelegate {
  func avatarOpener(avatarPickerDidPick image: UIImage) {
    groupProfileTableHeaderContainer.profileImageView.image = image
  }
  
  func avatarOpener(didPerformDeletionAction: Bool) {
    groupProfileTableHeaderContainer.profileImageView.image = nil
  }
}
