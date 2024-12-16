//
//  WeatherApiService.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import OSLog
import Foundation

/// A service class responsible for fetching weather information from the WeatherAPI.
final class WeatherApiService: WeatherService {
    
    /// API Key used for authentication with WeatherAPI.
    private let apiKey: String
    
    /// Initializes the WeatherApiService with the provided API key.
    /// - Parameter apiKey: The API key for WeatherAPI.
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    /// Searches for cities matching the query and retrieves their weather details.
    /// - Parameters:
    ///   - query: The search query string.
    ///   - logger: A logger instance for tracking activity.
    /// - Returns: An array of `CityWeather` objects containing weather details of matched cities.
    /// - Throws: `AppError` if an error occurs during the operation.
    func search(query: String, logger: Logger) async throws(AppError) -> [CityWeather] {
        let cities = try await getCities(query: query, logger: logger)
        let details = try await getDetails(cities: cities, logger: logger)
        await Task.yield()
        return details
    }
    
    /// Retrieves a list of cities matching the query.
    /// - Parameters:
    ///   - query: The search query string.
    ///   - logger: A logger instance for tracking activity.
    /// - Returns: An array of `CitySearchResponse` objects representing the matched cities.
    /// - Throws: `AppError` if no cities are found or a network error occurs.
    func getCities(query: String, logger: Logger) async throws(AppError) -> [CitySearchResponse] {
        let endpoint = "https://api.weatherapi.com/v1/search.json"
        let queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "q", value: query)
        ]
        
        let cities = try await performRequest(to: endpoint, queryItems: queryItems, expecting: [CitySearchResponse].self, logger: logger)
        guard !cities.isEmpty else {
            logger.debug("No cities found for query \(query).")
            throw AppError(kind: .cityNotFound, location: .here())
        }
        return cities
    }
    
    /// Retrieves weather details for the provided cities.
    /// - Parameters:
    ///   - cities: An array of `CitySearchResponse` objects.
    ///   - logger: A logger instance for tracking activity.
    /// - Returns: An array of `CityWeather` objects containing weather details for each city.
    /// - Throws: `AppError` if a network or decoding error occurs.
    func getDetails(cities: [CitySearchResponse], logger: Logger) async throws(AppError) -> [CityWeather] {
        do {
            return try await withThrowingTaskGroup(of: CityWeather.self, returning: [CityWeather].self) { group in
                for city in cities {
                    group.addTask {
                        return try await self.getDetail(city: city, logger: logger)
                    }
                }
                
                var results: [CityWeather] = []
                while let result = try await group.next() {
                    results.append(result)
                }
                return results
            }
        } catch let error as AppError {
            throw error
        } catch {
            throw AppError(kind: .networking, underlyingError: error, location: .here())
        }
    }
    
    /// Retrieves detailed weather information for a single city.
    /// - Parameters:
    ///   - city: A `CitySearchResponse` object representing the city.
    ///   - logger: A logger instance for tracking activity.
    /// - Returns: A `CityWeather` object containing detailed weather information for the city.
    /// - Throws: `AppError` if a network or decoding error occurs.
    func getDetail(city: CitySearchResponse, logger: Logger) async throws(AppError) -> CityWeather {
        let endpoint = "https://api.weatherapi.com/v1/current.json"
        let queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "q", value: city.url),
            URLQueryItem(name: "aqi", value: "no"),
        ]
        let response = try await performRequest(to: endpoint, queryItems: queryItems, expecting: CityCurrentResponse.self, logger: logger)
        
        return CityWeather(id: city.url,
                           cityName: city.name,
                           temperature: CityWeather.Temperature(value: response.current.tempC, unit: .celsius),
                           conditionIcon: .init(code: response.current.condition.code, url: response.current.condition.iconUrl),
                           humidity: response.current.humidity,
                           uvIndex: response.current.uv,
                           feelsLike: CityWeather.Temperature(value: response.current.feelsLikeC, unit: .celsius)
        )
    }
    
    /// Performs an HTTP request to the specified endpoint and decodes the response.
    /// - Parameters:
    ///   - rawUrl: The URL string for the API endpoint.
    ///   - queryItems: An array of `URLQueryItem` for constructing the request.
    ///   - expecting: The expected `Decodable` type for the response.
    ///   - logger: A logger instance for tracking activity.
    /// - Returns: A decoded object of the specified type.
    /// - Throws: `AppError` if a network or decoding error occurs.
    private func performRequest<T: Decodable>(to rawUrl: String, queryItems: [URLQueryItem], expecting: T.Type = T.self, logger: Logger) async throws(AppError) -> T {
        guard var urlComponents = URLComponents(string: rawUrl) else {
            logger.critical("Unable to produce URL from string \(rawUrl).")
            throw AppError(kind: .unexpectedNil, location: .here())
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            logger.critical("Unable to produce URL using query items \(queryItems).")
            throw AppError(kind: .unexpectedNil, location: .here())
        }
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                logger.critical("Unable to cast URLResponse to HTTPURLResponse.")
                throw AppError(kind: .unexpectedNil, location: .here())
            }
            guard httpURLResponse.statusCode == 200 else {
                logger.error("Unexpected status code \(httpURLResponse.statusCode).")
                throw AppError(kind: .networking, location: .here())
            }
            
            logger.info("Successfully retrieved \(data.count) bytes from \(url).")
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch let error as AppError {
            throw error
        } catch {
            throw AppError(kind: .networking, underlyingError: error, location: .here())
        }
    }
}
