//
//  Constants.swift
//  PlanetExplore
//
//  Created by Manju Kiran on 22/08/2019.
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import Foundation


// MARK: - Format Constants


public let coreDataContainerName = ""


// MARK: - Format Constants

public enum Formats : String {
    case date = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

// MARK: - Error Constants

/// String ENUMs to help guage the error code based on server response
enum DownloadError: String, Error {
    case badData = "Data is invalid"
    case redirectionError  = "Server Redirection error"
    case clientError = "Client not responding as expected"
    case serverError = "Server Error"
    case invalidRequest = "Request is invalid"
    case unknownError = "Unknown Error"
}

enum ImageError: String, Error {
    case badImageData = "Image Data is invalid"
}

/// Intervals
public enum Intervals : TimeInterval {
    case networkTimeoutInterval  = 30.0
    case imageCacheValidity = 86400.0 /// Image Cache validity - 24 hrs
}

/// Utility to get debug mode to crash the app whilst production apps function with a log.
/// We could instead change the non-debug macro to log data into a logger that can upload information for us instead.
#if DEBUG
    func debugLog(_ string: String) {
        fatalError(string)
    }
#else
    func debugLog(_ string: String) {
        print(string)
    }
#endif
