//
//  TestWeatherService.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import OSLog

final class TestWeatherService: WeatherService {
    
    func search(query: String, logger: Logger) async throws(AppError) -> [CityWeather] {
        // 1. Wait for some time.
        try! await Task.sleep(for: .seconds(Int.random(in: 1...5)))
        
        switch query {
        case "networking":
            throw AppError(kind: .networking, location: .here())
        case "city":
            throw AppError(kind: .cityNotFound, location: .here())
        default:
            return [.example]
        }
    }
}
