//
//  WeatherIcon.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

struct WeatherIcon: View {
    
    let icon: CityWeather.Icon
    @Environment(\.weatherImage) private var weatherImage
    
    var body: some View {
        if let name = weatherImage?.imageName(for: icon) {
            Image(name)
                .resizable()
                .scaledToFit()
        } else {
            AsyncImage(url: icon.url, content: { image in
                image
                    .resizable()
                    .scaledToFit()
            }, placeholder: {
                EmptyView()
            })
            .clipped()
        }
    }
}

#Preview {
    WeatherIcon(icon: CityWeather.example.conditionIcon)
}
