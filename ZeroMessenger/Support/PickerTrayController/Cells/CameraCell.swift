//
//  CameraCell.swift
//  ImagePickerTrayController
//
//  Created by Sandeep Mukherjee on 15.10.16.
//  Copyright © 2016 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class CameraCell: UICollectionViewCell {
    
    var cameraView: UIView? {
        willSet {
            cameraView?.removeFromSuperview()
        }
        didSet {
            if let cameraView = cameraView {
                contentView.addSubview(cameraView)
              setNeedsLayout()
            }
        }
    }
    
    var cameraOverlayView: UIView? {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cameraView?.frame = bounds
        cameraOverlayView?.frame = bounds
    }
    
}
