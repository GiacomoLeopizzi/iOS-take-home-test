//
//  Logger-Extension.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import OSLog

extension Logger {
    
    /// The subsystem identifier for the logger.
    /// This is typically the app's bundle identifier, which should always be present in the main bundle.
    private static var subsystem: String {
        Bundle.main.bundleIdentifier ?? ""
    }
    
    /// A shared logger for app-wide functionalities.
    /// Use this logger for logging messages that are not tied to a specific subsystem or category.
    static let shared = Logger(subsystem: subsystem, category: "shared")
}
