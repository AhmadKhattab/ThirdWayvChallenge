//
//  DefaultProductsRepository.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

// MARK: - Typealias
typealias CompletionHandler = (Result<[ProductDataModel], NetworkError>) -> Void

/// DefaultProductsRepository is used to fetch products from the suitable
/// data source based on the connectivity status of internet
final class DefaultProductsRepository: ProductsRepository {
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    private let cachingManager: ProductsCachingManagerProtocol
    // MARK: - Initializer(s)
    init(networkManger: NetworkManagerProtocol = NetworkManager(), cachingManager: ProductsCachingManagerProtocol = ProductsCachingManager()) {
        self.networkManager = networkManger
        self.cachingManager = cachingManager
    }
    // MARK: - Method(s)
    /// Fetch all products from the suitable data source based on internet connection status
    /// - Parameters:
    ///   - shouldCache: indicates whether we should the products returned from API in case
    ///   of internet connection is available
    ///   - completionHandler: block of code that will be executed once the products received or in case of failure
    func fetchProducts(shouldCache: Bool, completionHandler: @escaping CompletionHandler) {
        guard Network.reachability.isReachable else {
            let products = cachingManager.fetchProducts()
            products.isEmpty ? completionHandler(.failure(.noInternet)) : completionHandler(.success(products.toDomain()))
            return
        }
        networkManager.request(api: ProductsEndPoint.getProducts) { [weak self] (result: Result<Products, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                if shouldCache {
                    self.cachingManager.cacheProducts(products)
                }
                completionHandler(.success(products.toDomain()))
            case .failure(let error) where error == .noInternet:
                let products = self.cachingManager.fetchProducts()
                completionHandler(.success(products.toDomain()))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

// TODO: map returned DTO to domain layer model
