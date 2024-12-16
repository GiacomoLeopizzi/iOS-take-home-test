//
//  SearchView.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import SwiftUI

fileprivate struct ViewConstants {
    static let cornerRadius: CGFloat = 16
    static let iconSide: CGFloat = 17.49
    static let searchBarHorizontalPadding: CGFloat = 24
    static let contentHorizontalPadding: CGFloat = 20
    static let contentVerticalPadding: CGFloat = 24
    static let verticalPadding: CGFloat = 11
}

struct SearchView: View {
    
    @State var viewModel = SearchViewModel()
    @Environment(\.logger) var logger
    @Environment(\.weatherService) var service
    @Environment(\.cacheService) var cache
    
    @FocusState var isFocused: Bool
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBarView(text: $viewModel.searchQuery, onSubmit: search)
                .padding(.horizontal, ViewConstants.searchBarHorizontalPadding)
                .disabled(viewModel.isInteractionDisabled)
                .focused($isFocused)
            content
                .padding(.horizontal, ViewConstants.contentHorizontalPadding)
                .padding(.vertical, ViewConstants.contentVerticalPadding)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(edges: .bottom)
        }
        .animation(.easeInOut, value: viewModel.state)
        .task {
            viewModel.use(cache: cache)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard isFocused else {
                return
            }
            self.isFocused = false
        }
    }
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            IdleView()
        case .detail(let cityWeather):
            WeatherDetailView(weather: cityWeather, animation: animation)
        case .results(let cities):
            list(cities: cities)
        case .searching:
            ProgressView()
        case .error(let error):
            ErrorView(error: error)
        }
    }
    
    @ViewBuilder
    func list(cities: [CityWeather]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: ViewConstants.contentVerticalPadding) {
                ForEach(cities) { city in
                    WeatherView(weather: city, animation: animation)
                        .onTapGesture {
                            viewModel.onSelect(city: city, cache: cache)
                            guard isFocused else {
                                return
                            }
                            self.isFocused = false
                        }
                }
                Spacer()
            }
        }
    }
}

extension SearchView {
    
    func search() {
        viewModel.performSearch(using: service, logger: logger)
    }
}

#Preview {
    SearchView()
}
