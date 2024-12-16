//
//  WeatherDetailView.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

fileprivate struct ViewConstants {
    static let iconSide: CGFloat = 180
    
    static let positionIconSide: CGFloat = 21
    static let detailBoxWidth: CGFloat = 274
    static let spacing: CGFloat = 20
    
    static let cityNameFontSize: CGFloat = 30
    static let temperatureFontSize: CGFloat = 70
}

struct WeatherDetailView: View {
    
    @Environment(\.locale) var locale
    @Environment(\.temperatureFormatter) var formatter
    
    let weather: CityWeather
    let animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: ViewConstants.spacing) {
            icon
            cityName
            temperature
            DetailBox(cityWeather: weather, locale: locale)
                .frame(width: ViewConstants.detailBoxWidth)
        }
        .background(.white)
    }
    
    @ViewBuilder
    var icon: some View {
        WeatherIcon(icon: weather.conditionIcon)
            .matchedGeometryEffect(id: AnimationID.icon(weather), in: animation)
            .frame(width: ViewConstants.iconSide, height: ViewConstants.iconSide)
    }
    
    @ViewBuilder
    var cityName: some View {
        HStack {
            Text(verbatim: weather.cityName)
                .matchedGeometryEffect(id: AnimationID.cityName(weather), in: animation)
                .lineLimit(1)
                .font(.poppins(.semiBold, fixedSize: ViewConstants.cityNameFontSize))
                
            Image(.positionIcon)
                .resizable()
                .scaledToFit()
                .frame(width: ViewConstants.positionIconSide, height: ViewConstants.positionIconSide)
        }
    }
    
    @ViewBuilder
    var temperature: some View {
        Text(verbatim: formatter.format(weather.temperature, locale: locale))
            .lineLimit(1)
            .font(.poppins(.medium, fixedSize: ViewConstants.temperatureFontSize))
            .matchedGeometryEffect(id: AnimationID.temperature(weather), in: animation)
    }
}

#Preview("Fahrenheit") {
    @Previewable @Namespace var animation
    WeatherDetailView(weather: .example, animation: animation)
        .environment(\.locale, Locale(identifier: "en-US"))
}

#Preview("Celsius") {
    @Previewable @Namespace var animation
    WeatherDetailView(weather: .example, animation: animation)
        .environment(\.locale, Locale(identifier: "it-IT"))
}
