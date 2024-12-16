//
//  AnimationID.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

/// Hashable identifier used for animations.
enum AnimationID: Hashable {
    case icon(CityWeather)
    case cityName(CityWeather)
    case temperature(CityWeather)
}
