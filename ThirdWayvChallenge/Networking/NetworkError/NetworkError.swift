//
//  NetworkError.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

/// Networking Errors
///
enum NetworkError: Error {
    /// No internet
    ///
    case noInternet
    /// Resource Not Found (statusCode = 401)
    ///
    case authentication
    /// Resource Not Found (statusCode = 404)
    ///
    case notFound
    /// Request Timeout (statusCode = 408)
    ///
    case timeout
    /// Request Has no data
    ///
    case noData

    case unableToDecode
    /// Any statusCode that's not acceptable
    ///
    case unacceptableStatusCode
}
// MARK: - Public Methods
//
extension NetworkError {

    /// Designated Initializer
    ///
    init(from statusCode: Int) {
        switch statusCode {
        case StatusCode.notFound:
            self = .notFound
        case StatusCode.timeout:
            self = .timeout
        case StatusCode.authentication:
            self = .authentication
        default:
            self = .unacceptableStatusCode
        }
    }
    /// Constants
    ///
    private enum StatusCode {
        static let authentication = 401..<404
        static let notFound = 404
        static let timeout  = 408
    }
}
// MARK: - Network Error + Localized Error
extension NetworkError: LocalizedError {
    
    /// Error Description
    ///
    var errorDescription: String? {
        switch self {
        case .authentication:
            return "You need to be authenticated first."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."
        case .unacceptableStatusCode:
            return "We're having a few technical difficulties at the moment. We're working hard to get things sorted."
        case .notFound:
            return "Not found!"
        case .timeout:
            return "The connection has timed out"
        case .noInternet:
            return "Please check your internet connection"
        }
    }
}
