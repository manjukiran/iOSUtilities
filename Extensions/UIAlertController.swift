//
//  UIAlertController.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import UIKit
typealias alertActionHandler = ((UIAlertAction) -> Void)?

extension UIAlertController {
    
    class func generateSingleActionAlert(title: String, message: String, okHandler: alertActionHandler) -> UIAlertController{
        return UIAlertController.generateSimpleAlert(title: title, message: message,
                                                     dismissActionTitle: "OK".localized(),
                                                     dismissHandler: okHandler)
    }
    
    class func generateDoubleActionAlert(title: String, message: String,
                                   okHandler: alertActionHandler,
                                   cancelHandler: alertActionHandler? = nil) -> UIAlertController{
        return UIAlertController.generateSimpleAlert(title: title, message: message,
                                                 dismissActionTitle: "OK".localized(),
                                                 dismissHandler: okHandler,
                                                 secondaryActionTitle: "Cancel".localized(),
                                                 secondaryActionHandler: cancelHandler)
        
    }
    
    private class func generateSimpleAlert(title: String, message: String,
                                       dismissActionTitle: String?,
                                       dismissHandler: alertActionHandler,
                                       secondaryActionTitle: String? = nil,
                                       secondaryActionHandler: alertActionHandler? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: dismissActionTitle ?? "OK",
                                     style: .cancel, handler: dismissHandler)
        alertController.addAction(okAction)
        
        if let secondaryActionHandler = secondaryActionHandler {
            let secondaryAction = UIAlertAction(title: secondaryActionTitle ?? "OK",
                                                style: .default, handler: secondaryActionHandler)
            alertController.addAction(secondaryAction)
        }
        return alertController
    }
}
