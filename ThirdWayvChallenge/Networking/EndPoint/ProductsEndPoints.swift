//
//  ProductsEndPoints.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

enum ProductsEndPoint {
    /// Get all products
    case getProducts
}
// MARK: - ProductsEndPoint + EndPoint
extension ProductsEndPoint: EndPointType {
    // Base URL
    var baseURL: URL {
        return Environment.apiBaseURL
    }
    // End point path
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }
    // Method
    var httpMethod: HTTPMethod {
        switch self {
        case .getProducts:
             return .get
        }
    }
    // Task
    var task: HTTPTask {
        switch self {
        case .getProducts:
            return .request
        }
    }
    // Header
    var headers: HTTPHeaders? {
        nil
    }
}

