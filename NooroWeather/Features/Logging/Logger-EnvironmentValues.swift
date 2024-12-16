//
//  Logger-EnvironmentValues.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import OSLog
import SwiftUI

extension EnvironmentValues {
    
    /// Shared logger to be used for the application.
    @Entry var logger: Logger = .shared
}
