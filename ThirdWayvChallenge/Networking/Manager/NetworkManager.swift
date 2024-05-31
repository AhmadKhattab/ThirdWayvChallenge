//
//  NetworkManager.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

/// NetworkManager is a class responsible for fetching data from remote server
final class NetworkManager: NetworkManagerProtocol {
    // MARK: - Properties
    private let session: URLSession
    // MARK: - Init
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    // MARK: - Public Handler(s)
    /// Make URL session  request
    func request<T, E>(api: E, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, E : EndPointType {
        let urlRequest = buildRequest(from: api)
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            // error
            if  error != nil {
                
                completion(.failure(self.resolve(error: error)))
                return
            }
            
            // check response status code
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                let httpResponse = response as? HTTPURLResponse
                completion(.failure(NetworkError(from: httpResponse?.statusCode ?? 0)))
                return
            }
            // check response data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            // decode response
            guard let apiResponse = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.unableToDecode))
                return
            }
            
            completion(.success(apiResponse))
        })
        task.resume()
    }
}
// MARK: - Private Handlers
private extension NetworkManager {
    /// Converting `EndPointType` to `URLRequest`
    /// - Parameter route: End point to execute that conform to `EndPointType`
    /// - Returns: URLRequest
    func buildRequest(from route: EndPointType) -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            self.addAdditionalHeaders(route.headers, request: &request)
        }
        return request
    }
    /// Add additional headers to request
    /// - Parameters:
    ///   - additionalHeaders: Headers need to add
    ///   - request: URL request
    func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    /// Resolve url session error and check the internet connection
    /// - Parameter error: URL Session Error
    /// - Returns: Network Error
    func resolve(error: Error?) -> NetworkError {
        guard let error = error else { return .unacceptableStatusCode }
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .noInternet
        default: return .unacceptableStatusCode
        }
    }
}
