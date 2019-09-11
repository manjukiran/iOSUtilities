//
//  NetworkingUtility.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import Foundation
import UIKit

typealias dataHandler = (Result<Data, DownloadError>) -> Void

protocol URLDataFetching {
    func fetchDataWithURL(url: URL, completionHandler: @escaping dataHandler)
}

/**
 Main Network API interaction (GET) utility for Data retrieval
 
 - important: This is a generic utility that depends on the referring class to pass in the URL and a completion block
 - This is a singleton class (like the DataSyncManager and CoreDataManager) to help avoid threading issues
 */

class NetworkDataUtility : NSObject, URLDataFetching {
    
    static let shared = NetworkDataUtility()
    private var urlSession : URLSession?
    override private init() {
        super.init()
        self.urlSession = URLSession(configuration: URLSessionConfiguration.default,
                                     delegate: self, delegateQueue: nil)
    }
    
    
    /// Image Cache implemented to allow image data to be cached and retrieved upon need
    /// Access only if and when needed
    private lazy var imageCache = ImageCache()
    
    /// Primary function of the class - uses NSURLSession
    ///
    /// - Parameters:
    ///   - url: URL formed based on the URL (Refer to the Constants class for the baseURL + API endpoint)
    ///   - completionHandler: completion handler block with the result type
    
    func fetchDataWithURL(url: URL, completionHandler: @escaping dataHandler) {
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalCacheData,
                                    timeoutInterval: Intervals.networkTimeoutInterval.rawValue)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        DispatchQueue.global().async {
            self.urlSession?.dataTask(with: urlRequest) { (data, response, error) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(.serverError))
                    return
                }
                if let responseError = self.handleNetworkResponse(response: urlResponse) {
                    completionHandler(.failure(responseError))
                    return
                }
                if let urlData = data {
                    completionHandler(.success(urlData))
                    return
                } else {
                    completionHandler(.failure(.badData))
                    return
                }
                }.resume()
        }
    }
    
    
    /// Function to guage the response from the server
    ///
    /// - Parameter response: response received from the backend
    /// - Returns: optional error if the status is not 200..299
    private func handleNetworkResponse(response: HTTPURLResponse) -> DownloadError? {
        switch response.statusCode {
        case 200...299: return (nil)
        case 300...399: return (.redirectionError)
        case 400...499: return (.clientError)
        case 500...599: return (.serverError)
        case 600: return (.invalidRequest)
        default: return (.unknownError)
        }
    }
    
}

extension NetworkDataUtility : URLSessionDelegate {
    
    /// SSL Pinining Logic can be implemented here -> a certificate and a backup needs to be procured from the backned
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // SSL Pinining Logic can be implemented here -> a certificate and a backup needs to be procured from the backned
        completionHandler(.useCredential,nil)
    }
}

// MARK: - Extension to use the class a way to retrieve images (either from Cache if avaiable or from network)
extension NetworkDataUtility {
    
    typealias imageHandler = (Result<UIImage, ImageError>) -> Void
    
    /// Retrieves Image Data from URL (or Image cache)
    ///
    /// - Parameters:
    ///   - url: URL for image
    ///   - completionhandler: completion handler with results of the fetch
    func fetchImageDataWithUrl(url: URL, completionhandler: @escaping imageHandler) {
        let urlString = url.absoluteString as NSString
        if let image = self.imageCache.retrieveFromCache(urlString: urlString) {
            completionhandler(.success(image))
            return
        } else {
            self.fetchDataWithURL(url: url) { (result) in
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data){
                        self.imageCache.storeImageInCache(image: image, urlString: urlString)
                        completionhandler(.success(image))
                    } else {
                        completionhandler(.failure(.badImageData))
                    }
                    return
                case .failure(_) :
                    completionhandler(.failure(.badImageData))
                    return
                }
            }
        }
    }
}
