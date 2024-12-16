//
//  DiskCacheService.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import Foundation
import OSLog

/// A service for caching weather data to disk.
final class DiskCacheService: CacheService {
    
    /// The default URL for the cache file. Located in the system's temporary directory as "CityWeatherCache.json".
    static private var defaultCacheURL: URL {
        let url = URL(filePath: NSTemporaryDirectory(), directoryHint: .isDirectory)
        return url.appending(path: "CityWeatherCache").appendingPathExtension("json")
    }
    
    /// The file URL where the cache is stored.
    let cacheURL: URL
    /// Logger instance for logging cache operations.
    let logger: Logger
    
    /// Initializes the disk cache service with a specified cache URL and logger.
    /// - Parameters:
    ///   - cacheURL: The URL for the cache file. Defaults to `defaultCacheURL`.
    ///   - logger: A `Logger` instance for logging. Defaults to `.shared`.
    init(cacheURL: URL = DiskCacheService.defaultCacheURL, logger: Logger = .shared) {
        self.cacheURL = cacheURL
        self.logger = logger
    }
    
    /// Saves a `CityWeather` object to the cache asynchronously.
    /// - Parameter weather: The `CityWeather` object to be cached.
    func save(weather: CityWeather) {
        DispatchQueue.global().async {
            do {
                // Encode the weather object into JSON data.
                let data = try JSONEncoder().encode(weather)
                // Write the data to the cache file.
                try data.write(to: self.cacheURL)
            } catch {
                // Log an error if the save operation fails.
                self.logger.error("Failed to save cache. Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Retrieves the cached `CityWeather` object, if available.
    /// - Returns: A `CityWeather` object if the cache exists and can be read; otherwise, `nil`.
    func getWeather() -> CityWeather? {
        // Check if the cache file exists.
        guard FileManager.default.fileExists(atPath: cacheURL.path()) else {
            logger.trace("Cache file does not exist.")
            return nil
        }
        // Attempt to read the cache file data.
        guard let data = try? Data(contentsOf: cacheURL) else {
            logger.debug("Failed to read cache file.")
            return nil
        }
        logger.info("Read \(data.count) bytes from cache file.")
        // Decode the JSON data into a `CityWeather` object.
        return try? JSONDecoder().decode(CityWeather.self, from: data)
    }
}
