//
//  AccessibilityConfigurable.swift
//  iOS Utilities
//
//  Created by Manju Kiran on 22/08/2020.
//  Copyright © 2020 Manju Kiran. All rights reserved.
//

import UIKit

protocol AccessibilityConfigurable: class where Self: UIView  {
    func configureForAccessibility(with element: AccessibleElement)
}

extension UIView: AccessibilityConfigurable {
    
    func configureForAccessibility(with element: AccessibleElement) {
        self.accessibilityLabel = element.accessibleName
        self.accessibilityValue = element.accessibleValue
        self.accessibilityHint = element.accessibleRole
    }
    
}
