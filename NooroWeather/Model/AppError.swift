//
//  AppError.swift
//  NooroWeather
//
//  Created by Giacomo Leopizzi on 16/12/24.
//

import struct SwiftUI.LocalizedStringKey

/// A struct representing a custom application error conforming to the `Error` protocol.
struct AppError: Error {
    
    /// A struct that provides details about the location of an error in the code.
    struct Location: Hashable {
        /// The function where the error occurred.
        let function: String
        /// The file where the error occurred.
        let file: String
        /// The line number where the error occurred.
        let line: Int
        
        /// A static function to create a `Location` instance representing the current code location.
        /// - Parameters:
        ///   - function: The name of the function (default is the current function).
        ///   - file: The file identifier (default is the current file).
        ///   - line: The line number (default is the current line).
        /// - Returns: A `Location` instance.
        static func here(function: String = #function, file: String = #fileID, line: Int = #line) -> Location {
            return Location(function: function, file: file, line: line)
        }
    }
    
    /// An enumeration representing the type of error that occurred.
    enum Kind: Hashable {
        /// A networking-related error.
        case networking
        /// An error indicating that a city was not found.
        case cityNotFound
        ///
        case unexpectedNil
    }
    
    /// The kind of error that occurred.
    let kind: Kind
    /// The location in the code where the error occurred.
    let location: Location
    /// The underlying error, if any, that caused this error.
    let underlyingError: Error?
    
    /// Initializes a new instance of `AppError`.
    /// - Parameters:
    ///   - kind: The kind of error.
    ///   - underlyingError: The underlying error that caused this error, if any.
    ///   - location: The location in the code where the error occurred.
    init(kind: Kind, underlyingError: Error? = nil, location: Location) {
        self.kind = kind
        self.underlyingError = underlyingError
        self.location = location
    }
}

extension AppError: Equatable {
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        return lhs.kind == rhs.kind &&
        lhs.location == rhs.location
    }
}

extension AppError: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(kind)
        hasher.combine(location)
    }
}

extension AppError {
    
    /// A localized string description for the user, based on the error type.
    var userDescription: LocalizedStringKey {
        switch kind {
        case .networking:
            return "An error occurred while performing your request, please retry."
        case .cityNotFound:
            return "No city matching your search was found."
        case .unexpectedNil:
            return "An error occurred, please retry."
        }
    }
}
