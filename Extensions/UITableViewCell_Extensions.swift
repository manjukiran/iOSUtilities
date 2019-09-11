//
//  UITableViewCell.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    
    /// Simple utility to help access the reuse identifier of every cell class without having to rely on hardcoded strings
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
