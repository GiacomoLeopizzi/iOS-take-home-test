//
//  DiskCacheService-EnvironmentValues.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

extension EnvironmentValues {
    
    /// Shared cache service to be used for the application.
    @Entry var cacheService: CacheService? = nil
}
