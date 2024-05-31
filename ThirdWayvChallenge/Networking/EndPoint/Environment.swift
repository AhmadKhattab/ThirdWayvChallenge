//
//  Environment.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

/// `Environment`  Contains BaseURL and API access token
///
enum Environment {
    // API base url
    static let apiBaseURL: URL = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: PlistKeys.baseURL) as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        guard let url = URL(string: "https://\(apiBaseURL)") else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
}
// MARK: - Plist Keys
private extension Environment {
    enum PlistKeys {
        static let baseURL = "SERVER_URL"
    }
}
