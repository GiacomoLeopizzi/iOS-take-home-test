//
//  WeatherService.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import OSLog

/// A protocol defining the interface for a weather service.
///
/// Conforming types must implement asynchronous weather search functionality.
protocol WeatherService: Sendable {
    
    /// Searches for cities matching the given query.
    /// - Parameters:
    ///   - query: The search string to query for cities.
    ///   - logger: A logger for recording debug or error information.
    /// - Returns: An array of `CityWeather` objects matching the query.
    /// - Throws: An `AppError` if the search fails.
    func search(query: String, logger: Logger) async throws(AppError) -> [CityWeather]
}


