//
//  NetworkMockUtility.swift
//  iOSUtilities Tests
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import Foundation
@testable import PlanetExplore

enum NetworkMockUtility {
    
    struct SuccessfulNetworkFetch : URLDataFetching {
        let data: Data
        func fetchDataWithURL(url: URL, completionHandler: @escaping dataHandler) {
            completionHandler(.success(data))
        }
    }
    
    struct FailedNetworkFetch : URLDataFetching {
        func fetchDataWithURL(url: URL, completionHandler: @escaping dataHandler) {
            completionHandler(.failure(DownloadError.serverError))
        }
    }
    
    struct SuccessfulPlanetsFetch : URLDataFetching, PlanetsListFetcher  {
        let data: Data
        
        func fetchDataWithURL(url: URL, completionHandler: @escaping dataHandler) {
            completionHandler(.success(data))
        }
        
        func retrieveInitialPlanetsList(completion: @escaping genericDataFetchHandler<PlanetsData>){
            
            
        }
    }
}





