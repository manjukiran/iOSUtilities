//
//  DataSyncManager.swift
//  iOS Utilities
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import UIKit


/// Generic Data Fetch Completion block with expectations from classes to inject the Class of the data to be decoded
typealias genericDataFetchHandler<T:Codable>  = (Result<T, DownloadError>) -> Void

/**
 Main API Data retrieval utility that is used by all Models/View models to retrieve data and decode (into Codables)
 
 - important: This is a generic utility that depends on the referring class to pass in the the type of codable to de-code
 - This is class is injected with a <URLDataFetching> object to aid in testing 
 
 Whilst being light weight, it depends on the NetworkDataUtility class to fetch data via URLSession
 */

class DataSyncManager {
    
    private let networkDataUtility: URLDataFetching
    required init(networkDataUtility: URLDataFetching){
        self.networkDataUtility  = networkDataUtility
    }
    
    /// Primary function of the class - Uses the NetworkDataUtility class to retrieve data and decodes into a native iOS object
    ///
    /// - Parameters:
    ///   - urlString: URL of the API endpoint to hit
    ///   - completion: Completion block that is injected;
    /// - Expectation :
    ///   Completion block expects the Data type of the class to be decoded ; this class MUST conform to CODABLE protocols
    ///   This is a SWIFT 5 result block that provides the result (success/failure) along with response (data/error)
    public func retrieveData<T: Codable>(urlString: String , completion: @escaping genericDataFetchHandler<T>)  {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidRequest))
            return
        }
        self.networkDataUtility.fetchDataWithURL(url: url) { (result) in
            switch result {
            case .success (let data) :
                completion(self.decode(data: data, type: T.self))
            case .failure (let error) :
                completion(.failure(error))
            }
        }
    }
    
    /// Used to decode the data retrieved from the API into the data object
    ///
    /// - Parameters:
    ///   - data: data retrieved from the API
    ///   - type: Class of the data to be decoded into
    /// - Returns: Swift 5 Result type -> either a (Success+DecodedData) //OR// (Failure+Error) tuple
    private func decode<T : Codable>(data: Data, type: T.Type) -> Result<T,DownloadError> {
        let jsonDecoder = JSONDecoder(context: CoreDataManager.shared.context)
        do {
            let decodedObject = try jsonDecoder.decode(T.self, from: data)
            return(.success(decodedObject))
        } catch let error {
            print (error.localizedDescription)
            return(.failure(.badData))
        }
    }
}


// MARK: - Use this area to add new API Request that newer classes or viewmodels can use for data retrieval
extension DataSyncManager : PlanetsListFetcher {
    
    /// Retrieve the first page of the list of planets
    ///
    /// - Parameter completion: completion handler which expects the Data Type of the class to be decoded
    func retrieveInitialPlanetsList(completion: @escaping genericDataFetchHandler<PlanetsData>) {
        self.retrievePlanetsList(page: 1,
                                 completion: completion)
    }
    
    /// Retrieve the  the list of planets
    ///
    /// - Parameters:
    ///   - page: number of the paged request for API
    ///   - completion: completion handler which expects the Data Type of the class to be decoded
    internal func retrievePlanetsList(page: Int, completion: @escaping genericDataFetchHandler<PlanetsData>) {
        self.retrieveData(urlString: APIEndpoint.planets.pagedURLString(page: page),
                          completion: completion)
    }
    
}
