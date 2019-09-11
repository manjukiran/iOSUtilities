//
//  UIView_Extensions.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import UIKit

extension UIView {
    
    /// UIView utility to ensure provided block runs on Main Thread
    ///
    /// Also helps avoid EXC_BAD_INSTRUCTION errors
    ///
    /// - Parameter block: closure containing the code to run
    class func runOnMainThread(block: () -> ()) {
        if Thread.isMainThread {
            block()
            return
        }
        DispatchQueue.main.sync {
            block()
        }
    }
}
