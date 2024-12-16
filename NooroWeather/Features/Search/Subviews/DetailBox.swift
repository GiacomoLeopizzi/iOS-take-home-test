//
//  DetailBox.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

fileprivate struct ViewConstants {
    static let cornerRadius: CGFloat = 16
    static let spacing: CGFloat = 16
    static let titleFontSize: CGFloat = 12
    static let valueFontSize: CGFloat = 15
}


struct DetailBox: View {
    
    typealias Info = (title: String, value: LosslessStringConvertible)
    
    let info: [Info]
    
    var body: some View {
        HStack(spacing: ViewConstants.spacing) {
            ForEach(info, id: \.title) { item in
                VStack(spacing: 8) {
                    Text(item.title)
                        .font(.poppins(.medium, fixedSize: ViewConstants.titleFontSize))
                        .foregroundStyle(.appSecondaryText)
                    Text(verbatim: String(item.value))
                        .font(.poppins(.medium, fixedSize: ViewConstants.valueFontSize))
                        .foregroundStyle(.appTertiaryText)
                }
                .lineLimit(1)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(16)
        .background(.weatherViewBackground)
        .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
        
    }
}

extension DetailBox {
    
    init(cityWeather: CityWeather, locale: Locale) {
        self.info = [
            ("Humidity", cityWeather.humidity),
            ("UV", cityWeather.uvIndex),
            ("Feels Like", TemperatureFormatter().format(cityWeather.feelsLike, locale: locale))
        ]
    }
}

#Preview("Fahrenheit") {
    DetailBox(cityWeather: .example, locale: Locale(identifier: "en-US"))
}

#Preview("Celsius") {
    DetailBox(cityWeather: .example, locale: Locale(identifier: "it-IT"))
}
