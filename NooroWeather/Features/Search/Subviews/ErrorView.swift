//
//  ErrorView.swift
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

struct ErrorView: View {
    
    let error: AppError
    
    var body: some View {
        VStack(spacing: ViewConstants.spacing) {
            Text("Whoops!")
                .font(.poppins(.semiBold, fixedSize: ViewConstants.titleFontSize))
                .lineLimit(1)
            Text(error.userDescription)
                .font(.poppins(.semiBold, fixedSize: ViewConstants.subtitleFontSize))
        }
        .multilineTextAlignment(.center)
        .minimumScaleFactor(0.5)
        .foregroundStyle(.appPrimaryText)
    }
}

#Preview("Networking") {
    ErrorView(error: AppError(kind: .networking, location: .here()))
}

#Preview("Not found") {
    ErrorView(error: AppError(kind: .cityNotFound, location: .here()))
}
