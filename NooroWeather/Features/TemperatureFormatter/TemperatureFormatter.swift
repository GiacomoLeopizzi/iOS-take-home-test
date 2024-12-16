//
//  TemperatureFormatter.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import Foundation

final class TemperatureFormatter {
    
    /// Formats a temperature value into a localized string representation.
    /// - Parameters:
    ///   - temperature: The temperature value to format, represented as a `Measurement<UnitTemperature>`.
    ///   - locale: The locale to use for formatting the temperature.
    /// - Returns: A localized string representation of the temperature.
    func format(_ temperature: Measurement<UnitTemperature>, locale: Locale) -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = locale
        formatter.unitOptions = .naturalScale
        formatter.numberFormatter.maximumFractionDigits = 0
        return String(formatter.string(from: temperature).dropLast())
    }
}
