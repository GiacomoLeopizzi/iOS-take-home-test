//
//  CityCurrentResponse.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import Foundation

extension WeatherApiService {
    
    /// Represents the response for the current weather data from the Weather API.
    struct CityCurrentResponse: Decodable {
        
        /// Represents the current weather conditions.
        struct Current: Decodable {
            
            enum CodingKeys: String, CodingKey {
                case tempC = "temp_c"
                case condition
                case humidity
                case uv
                case feelsLikeC = "feelslike_c"
            }
            
            /// Represents the condition details (e.g., code and icon URL).
            struct Condition: Decodable {
                /// Weather condition code.
                var code: Int
                /// Icon URL string.
                var icon: String
            }
            
            /// Current temperature in Celsius.
            var tempC: Double
            /// Weather condition details.
            var condition: Condition
            /// Current humidity percentage.
            var humidity: Int
            /// UV index.
            var uv: Double
            /// Feels-like temperature in Celsius.
            var feelsLikeC: Double
        }
        
        /// Current weather details.
        var current: Current
    }
}

extension WeatherApiService.CityCurrentResponse.Current.Condition {
    /// Constructs a full URL for the condition icon.
    var iconUrl: URL {
        URL(string: "https:\(self.icon)")!
    }
}
