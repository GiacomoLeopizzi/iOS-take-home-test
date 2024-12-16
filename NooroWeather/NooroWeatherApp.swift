//
//  NooroWeatherApp.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

@main
struct NooroWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environment(\.colorScheme, .light)
                .preferredColorScheme(.light)
                .environment(\.weatherService, WeatherApiService(apiKey: "HERE THE API KEY"))
                .environment(\.cacheService, DiskCacheService())
                .environment(\.weatherImage, WeatherImage())
        }
    }
}
