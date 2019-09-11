//
//  Codable_CoreData.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import UIKit
import CoreData

extension CodingUserInfoKey {
    
    /// Defines key for the JSONDecoder object to maintain a reference to the managed object context
    /// whilst decoding a Codable
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    
    /// Convenience INIT Utility to provide a function to ensure a reference to
    /// the NSManagedObjectContext can be maintained
    ///
    /// - Parameter context: managed object context for the Core-data persistence co-ordinator
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
