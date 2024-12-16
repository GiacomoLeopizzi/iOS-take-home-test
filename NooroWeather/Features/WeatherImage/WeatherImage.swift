//
//  WeatherImage.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import Foundation

/// A final class responsible for managing weather images based on a given weather code.
final class WeatherImage {
    
    /// A nested struct representing the combination of weather codes and their corresponding icon names.
    struct Combination: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case code
            case iconName = "icon-name"
        }
        
        /// The weather condition code./
        let code: Int
        /// The name of the icon corresponding to the weather code./
        let iconName: String
    }
    
    /// A dictionary mapping weather condition codes to icon names.
    private let combinations: [Int: String]
    
    /// Initializes the `WeatherImage` object and loads the combinations from a JSON file.
    init() {
        // Attempt to find the "weather_images.json" file in the main bundle.
        guard let url = Bundle.main.url(forResource: "weather_images", withExtension: "json") else {
            // If the file is not found, initialize an empty dictionary.
            self.combinations = [:]
            return
        }
        do {
            // Attempt to read data from the JSON file.
            let data = try Data(contentsOf: url)
            // Decode the JSON data into an array of `Combination` objects and map them into key-value pairs.
            let combinations = try JSONDecoder().decode([Combination].self, from: data).map {
                ($0.code, $0.iconName)
            }
            // Convert the array of key-value pairs into a dictionary.
            self.combinations = Dictionary(uniqueKeysWithValues: combinations)
        } catch {
            // If any error occurs during file reading or decoding, initialize an empty dictionary.
            self.combinations = [:]
        }
    }
    
    /// Returns the icon name corresponding to a given weather condition code.
    /// - Parameter icon: A `CityWeather.Icon` instance representing the weather condition.
    /// - Returns: The name of the corresponding icon, or `nil` if no match is found.
    func imageName(for icon: CityWeather.Icon) -> String? {
        return combinations[icon.code]
    }
}
