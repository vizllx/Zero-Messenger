//
//  ChatLogController+ChatHistoryFetcherDelegate.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

extension ChatLogController: ChatLogHistoryDelegate {
  
  func chatLogHistory(isEmpty: Bool) {
    refreshControl.endRefreshing()
  }
  
  func chatLogHistory(updated messages: [Message], at indexPaths: [IndexPath]) {
    contentSizeWhenInsertingToTop = collectionView?.contentSize
    isInsertingCellsToTop = true
    refreshControl.endRefreshing()
    
    self.messages = messages
    
    UIView.performWithoutAnimation {
      collectionView?.performBatchUpdates ({
        collectionView?.insertItems(at: indexPaths)
      }, completion: nil)
    }
  }
}
