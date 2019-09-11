//
//  JSONUtlity.swift
//  iOSUtilities Tests
//
//  Created by Manju Kiran 
//  Copyright © 2019 Manju Kiran. All rights reserved.
//

import XCTest

@testable import PlanetExplore
class JSONUtlity {
    
    static let decoder = JSONDecoder(context: CoreDataManager.shared.context)
    
    private static func dataFromJSONFile(named fileName: String) throws -> Data {
        return try FileUtility.data(forFileName: fileName, withExtension: "json")
    }
    
    static func planetsJSONData() throws -> Data {
        return try dataFromJSONFile(named: "Planets")
    }
    
    static func singlePlanetJSONData() throws -> Data {
        return try dataFromJSONFile(named: "1-Planet")
    }
    
    static func moviesJSONData() throws -> Data {
        return try dataFromJSONFile(named: "Movies")
    }
    
    static func singleMovieJSONData() throws -> Data {
        return try dataFromJSONFile(named: "1-Movie")
    }
    
    static func decodePlanetsListFromJson() throws -> [Planet]? {
        return try decoder.decode(PlanetsData.self, from: singlePlanetJSONData()).planets
    }
    
    static func decodePlanetFromJson() throws -> Planet {
        return try decoder.decode(Planet.self, from: singlePlanetJSONData())
    }
    
    static func decodeMovieListFromJson() throws -> [Movie] {
        return try decoder.decode([Movie].self, from: moviesJSONData())
    }
    
    static func decodeMovieFromJson() throws -> Movie {
        return try decoder.decode(Movie.self, from: singleMovieJSONData())
    }
}
