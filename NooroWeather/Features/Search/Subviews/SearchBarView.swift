//
//  SearchBarView.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

fileprivate struct ViewConstants {
    static let cornerRadius: CGFloat = 16
    static let iconSide: CGFloat = 17.49
    static let horizontalPadding: CGFloat = 20
    static let verticalPadding: CGFloat = 11
    static let fontSize: CGFloat = 15
}

struct SearchBarView: View {
    
    @Binding var text: String
    let onSubmit: () -> Void
    
    var body: some View {
        HStack(spacing: ViewConstants.verticalPadding) {
            textField
            icon
        }
        .padding(.vertical, ViewConstants.verticalPadding)
        .padding(.horizontal, ViewConstants.horizontalPadding)
        .background(.searchBarBackground)
        .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
    }
    
    @ViewBuilder
    var textField: some View {
        TextField("", text: $text, prompt: Text("Search Location").foregroundColor(.appSecondaryText))
            .font(.poppins(.regular, fixedSize: ViewConstants.fontSize))
            .foregroundStyle(.appPrimaryText)
            .submitLabel(.search)
            .onSubmit(onSubmit)
        
    }
    
    @ViewBuilder
    var icon: some View {
        Image(.magnifyingGlassIcon)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.searchBarIcon)
            .frame(width: ViewConstants.iconSide, height: ViewConstants.iconSide)
    }
}

#Preview {
    @Previewable @State var text = ""
    SearchBarView(text: $text, onSubmit: { })
}
