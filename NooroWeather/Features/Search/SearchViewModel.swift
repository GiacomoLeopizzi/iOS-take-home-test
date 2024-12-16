//
//  SearchViewModel.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import Observation
import Combine
import OSLog

@MainActor
@Observable
final class SearchViewModel {
    
    /// Represents the current state of the view model.
    enum State: Hashable {
        /// Initial state.
        case idle
        /// Showing details for a selected or cached city.
        case detail(CityWeather)
        /// Displaying search results.
        case results([CityWeather])
        /// Search is in progress.
        case searching
        /// An error occurred
        case error(AppError)
    }
    
    /// The current state of the view model.
    private(set) var state: State
    
    /// Indicates whether user interaction should be disabled.
    var isInteractionDisabled: Bool {
        state == .searching
    }
    
    /// The user's search query.
    var searchQuery: String
    
    /// Initializes the view model to its default state.
    init() {
        self.state = .idle
        self.searchQuery = ""
    }
    
    /// Loads weather details from the cache if available.
    func use(cache: CacheService?) {
        guard let cached = cache?.getWeather() else { return }
        self.state = .detail(cached)
    }
    
    /// Updates the state with the selected city and caches it.
    func onSelect(city: CityWeather, cache: CacheService?) {
        self.state = .detail(city)
        cache?.save(weather: city)
    }
    
    /// Performs a search using the provided weather service.
    /// - Parameters:
    ///   - service: The weather service to query.
    ///   - logger: A logger for debug messages.
    func performSearch(using service: WeatherService, logger: Logger) {
        guard !isInteractionDisabled else {
            logger.debug("Cannot search in current state: \(String(describing: self.state))")
            return
        }
        
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else {
            logger.debug("Search query is empty. Resetting to idle state.")
            self.state = .idle
            return
        }
        
        self.state = .searching
        Task { @MainActor in
            do throws(AppError) { // Workaround for Xcode error.
                let cities = try await service.search(query: searchQuery, logger: logger)
                self.state = .results(cities)
                self.searchQuery = ""
            } catch {
                self.state = .error(error)
            }
        }
    }
}
