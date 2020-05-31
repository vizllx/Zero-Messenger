//
//  UIImageExtensions.swift
//  ImagePickerTrayController
//
//  Created by Sandeep Mukherjee on 24.11.16.
//  Copyright © 2016 Sandeep Mukherjee. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(bundledName name: String) {
        let bundle = Bundle(for: ImagePickerTrayController.self)
        self.init(named: name, in: bundle, compatibleWith:nil)
    }
    
}
