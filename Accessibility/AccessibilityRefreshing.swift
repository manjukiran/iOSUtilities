//
//  AccessibilityRefreshing.swift
//  iOS Utilities
//
//  Created by Manju Kiran on 22/08/2020.
//  Copyright © 2020 Manju Kiran. All rights reserved.
//

import UIKit

@objc protocol AccessibilityRefreshing where Self: UIViewController {
    
    @objc func refreshWhenAccessibilityChanges()
}

@objc public class AccessibilityRefreshingViewController: UIViewController, AccessibilityRefreshing {

    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshWhenAccessibilityChanges),
                                               name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc internal func refreshWhenAccessibilityChanges() { }
    
}

