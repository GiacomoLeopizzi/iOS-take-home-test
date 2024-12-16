//
//  CacheService.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

/// A protocol for caching weather data.
protocol CacheService: Sendable {
    
    /// Saves a `CityWeather` object to the cache.
    /// - Parameter weather: The weather data to be cached.
    func save(weather: CityWeather)
    
    /// Retrieves the cached `CityWeather` object, if available.
    /// - Returns: The cached `CityWeather` object, or `nil` if no data is available.
    func getWeather() -> CityWeather?
}

