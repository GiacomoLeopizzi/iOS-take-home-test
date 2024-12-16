//
//  WeatherView.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

fileprivate struct ViewConstants {
    static let cornerRadius: CGFloat = 16
    
    static let iconSide: CGFloat = 83
    static let verticalSpacing: CGFloat = 8
    static let horizontalSpacing: CGFloat = 24
    
    static let cityFontSize: CGFloat = 20
    static let temperatureFontSize: CGFloat = 60
}

struct WeatherView: View {
    
    let weather: CityWeather
    let animation: Namespace.ID
    
    @Environment(\.locale) var locale
    @Environment(\.temperatureFormatter) var formatter
    
    var body: some View {
        HStack(spacing: 0) {
            texts
            Spacer(minLength: 0)
            icon
        }
        .padding(.horizontal, ViewConstants.horizontalSpacing)
        .padding(.vertical, ViewConstants.verticalSpacing)
        .background(.weatherViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
    }
    
    var texts: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(verbatim: weather.cityName)
                .font(.poppins(.semiBold, fixedSize: ViewConstants.cityFontSize))
                .matchedGeometryEffect(id: AnimationID.cityName(weather), in: animation)

            Text(formatter.format(weather.temperature, locale: locale))
                .font(.poppins(.medium, fixedSize: ViewConstants.temperatureFontSize))
                .matchedGeometryEffect(id: AnimationID.temperature(weather), in: animation)
        }
        .foregroundStyle(.appPrimaryText)
        .lineLimit(1)
    }
    
    @ViewBuilder
    var icon: some View {
        WeatherIcon(icon: weather.conditionIcon)
            .matchedGeometryEffect(id: AnimationID.icon(weather), in: animation)
            .frame(width: ViewConstants.iconSide, height: ViewConstants.iconSide)
    }
}

#Preview {
    @Previewable @Namespace var animation
    
    WeatherView(weather: .example, animation: animation)
        .environment(\.locale, Locale(identifier: "en-US"))
    
    WeatherView(weather: .example, animation: animation)
        .environment(\.locale, Locale(identifier: "it-IT"))
}
