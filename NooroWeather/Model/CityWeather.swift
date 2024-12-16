//
//  CityWeather.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import Foundation

/// A model representing the weather information for a specific city.
struct CityWeather: Hashable, Identifiable, Codable {
    
    /// A nested model representing the icon for a weather condition.
    struct Icon: Hashable, Codable {
        /// The code associated with the weather icon.
        var code: Int
        /// The URL pointing to the weather icon image.
        var url: URL
    }
    
    /// A typealias for representing temperature measurements in a specific unit.
    typealias Temperature = Measurement<UnitTemperature>
    
    /// A unique identifier for the city.
    var id: String
    /// The name of the city.
    var cityName: String
    /// The current temperature in the city.
    var temperature: Temperature
    /// An icon representing the current weather condition (e.g., "Sunny", "Cloudy").
    var conditionIcon: Icon
    /// The relative humidity in the city, represented as a percentage (0 - 100).
    var humidity: Int
    /// The UV index, representing the intensity of ultraviolet radiation.
    var uvIndex: Double
    /// The "feels like" temperature, representing the perceived temperature.
    var feelsLike: Temperature
}
