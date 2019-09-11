//
//  UIViewController_Extensions.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Simple utility to help access the storyboard identifier of every view controller class without having to rely on hardcoded strings
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }

}
