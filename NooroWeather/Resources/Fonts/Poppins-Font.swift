//
//  Poppins-Font.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

extension Font {
    
    enum PoppinsFontWeight: String {
        case thinItalic = "Poppins-ThinItalic"
        case thin = "Poppins-Thin"
        case semiBoldItalic = "Poppins-SemiBoldItalic"
        case semiBold = "Poppins-SemiBold"
        case regular = "Poppins-Regular"
        case mediumItalic = "Poppins-MediumItalic"
        case medium = "Poppins-Medium"
        case lightItalic = "Poppins-LightItalic"
        case light = "Poppins-Light"
        case italic = "Poppins-Italic"
        case extraLightItalic = "Poppins-ExtraLightItalic"
        case extraLight = "Poppins-ExtraLight"
        case extraBoldItalic = "Poppins-ExtraBoldItalic"
        case extraBold = "Poppins-ExtraBold"
        case boldItalic = "Poppins-BoldItalic"
        case blackItalic = "Poppins-BlackItalic"
        case bold = "Poppins-Bold"
        case black = "Poppins-Black"
    }

    static func poppins(_ weight: PoppinsFontWeight, fixedSize: CGFloat) -> Font {
        return .custom(weight.rawValue, fixedSize: fixedSize)
    }
}

