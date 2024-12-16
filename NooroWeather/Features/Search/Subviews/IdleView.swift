//
//  IdleView.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

fileprivate struct ViewConstants {
    static let spacing: CGFloat = (60 - 30) / 2
    static let titleFontSize: CGFloat = 30
    static let subtitleFontSize: CGFloat = 15
}

struct IdleView: View {
    var body: some View {
        VStack(spacing: ViewConstants.spacing) {
            Text("No City Selected")
                .font(.poppins(.semiBold, fixedSize: ViewConstants.titleFontSize))
            Text("Please Search For A City")
                .font(.poppins(.semiBold, fixedSize: ViewConstants.subtitleFontSize))
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .foregroundStyle(.appPrimaryText)
    }
}

#Preview {
    IdleView()
}
