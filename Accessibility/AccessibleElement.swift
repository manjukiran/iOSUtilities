//
//  Constants.swift
//  iOS Utilities
//
//  Created by Manju Kiran on 22/08/2020.
//  Copyright © 2020 Manju Kiran. All rights reserved.
//

import UIKit

protocol AccessibleElement {
    
    var accessibleName: String? { get }
    var accessibleRole: String? { get }
    var accessibleValue: String? { get }
}
