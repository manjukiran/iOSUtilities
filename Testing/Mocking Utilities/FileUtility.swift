//
//  FileUtility.swift
//  iOSUtilities Tests
//
//  Created by Manju Kiran
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import CoreFoundation

class FileUtility: NSObject {
    struct FileNotFoundError: Error {}
    
    static func data(forFileName fileName: String, withExtension fileExtension: String) throws -> Data {
        guard let url = Bundle(for: self).url(forResource: fileName,
                                              withExtension: fileExtension) else {
                                                throw FileNotFoundError()
        }
        return try Data(contentsOf: url)
    }}
