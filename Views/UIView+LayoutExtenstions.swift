//
//  UIView+LayoutExtenstions.swift
//  iOS Utilities
//
//  Created by Manju Kiran on 27/01/2020.
//

import UIKit

internal extension UIView {
    
    func alignTo(edges: [NSLayoutConstraint.Attribute], offset: CGFloat = 0) {
        DispatchQueue.main.async {
            self.translatesAutoresizingMaskIntoConstraints = false
            for edge in edges {
                self.alignmentConstraint(attribute: edge, offset: offset)
            }
        }
    }
  
    func applySize(width: CGFloat? = nil, height: CGFloat? = nil) {
        DispatchQueue.main.async {
            self.translatesAutoresizingMaskIntoConstraints = false
            if let width = width {
                self.addConstraint(NSLayoutConstraint(item: self,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1,
                                                      constant: width))
                
            }
            if let height = height {
                self.addConstraint(NSLayoutConstraint(item: self,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1,
                                                      constant: height))
                
            }
        }
    }
    
}

extension UIView {
    
    private func alignmentConstraint(attribute: NSLayoutConstraint.Attribute, offset: CGFloat = 0.0) {
        guard let containerView = self.superview else {
            fatalError("No SuperView Found")
        }
        let multiplier: CGFloat = (attribute == .bottom || attribute == .trailing) ? -1.0 : 1.0
        
        NSLayoutConstraint(item: self,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: containerView,
                           attribute: attribute,
                           multiplier: 1,
                           constant: (offset * multiplier)).isActive = true
    }
    
}
