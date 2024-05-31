//
//  ProductsViewModel.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

// MARK: - Requirements
protocol ProductsViewModelInput {
    func fetchProducts(shouldCache: Bool)
}
protocol ProductsViewModelOutput {
    var productsObservable: Observable<[ProductDataModel]> { get set }
    var loadingObservable: Observable<Bool> { get set }
    var errorObservable: Observable<ErrorMessage> { get set }
}
// MARK: - Typealias
typealias ProductsViewModelProtocol = ProductsViewModelInput & ProductsViewModelOutput
typealias ErrorMessage = String

class ProductsViewModel: ProductsViewModelProtocol {
    // MARK: - Properties
    private let productsRepository: ProductsRepository
    var productsObservable: Observable<[ProductDataModel]>
    var loadingObservable: Observable<Bool>
    var errorObservable: Observable<ErrorMessage>
    // MARK: - Initializer(s)
    init(with productsRepository: ProductsRepository = DefaultProductsRepository()) {
        self.productsRepository = productsRepository
        productsObservable = Observable([])
        loadingObservable = Observable(false)
        errorObservable = Observable(nil)
    }
    // MARK: - Method(s)
    
    /// Fetch all products from products repository
    /// - Parameter shouldCache: indicates whether we need to cache the response or not from Products API
    func fetchProducts(shouldCache: Bool) {
        self.loadingObservable.value = true
        productsRepository.fetchProducts(shouldCache: shouldCache) { [weak self] (result: Result<[ProductDataModel], NetworkError>) in
            guard let self = self else { return }
            self.loadingObservable.value = false
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.productsObservable.value?.append(contentsOf: products)
                }
            case .failure(let error):
                self.errorObservable.value = error.errorDescription
            }
        }
    }
}
