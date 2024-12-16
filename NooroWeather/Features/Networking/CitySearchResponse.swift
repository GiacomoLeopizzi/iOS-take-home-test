//
//  CitySearchResponse.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

extension WeatherApiService {
    
    /// Represents the response for a city search from the Weather API.
    struct CitySearchResponse: Decodable {
        /// The name of the city.
        var name: String
        /// The URL associated with the city (e.g., for more details).
        var url: String
    }
}

