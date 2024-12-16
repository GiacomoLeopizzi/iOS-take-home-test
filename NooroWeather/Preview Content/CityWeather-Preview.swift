//
//  CityWeather-Preview.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import Foundation

extension CityWeather {
    
    /// Example object used in previews.
    static var example: CityWeather {
        CityWeather(id: "chicago-usa",
                    cityName: "Chicago",
                    temperature: Temperature(value: 22.45758, unit: .celsius),
                    conditionIcon: Icon(code: 1003, url: URL(string: "https://cdn.weatherapi.com/weather/64x64/night/116.png")!),
                    humidity: 35,
                    uvIndex: 3,
                    feelsLike: Temperature(value: 25, unit: .celsius))
    }
}
