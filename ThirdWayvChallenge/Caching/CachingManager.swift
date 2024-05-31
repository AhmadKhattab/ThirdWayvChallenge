//
//  CachingManager.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 17/12/2022.
//

import Foundation

class ProductsCachingManager: ProductsCachingManagerProtocol {
    
    /// Fetch Products from disk cache.
    /// - Returns: all the cached products and empty array in case of
    /// there's no products cached
    func fetchProducts() -> Products {
        let products: Products = DiskCacheStore.shared.retrieveEntry(with: productsCachingKey)?.getEntryObject() ?? []
        return products
    }
    /// Save products into disk cache.
    /// - Parameter products: the products to be saved in disk cache
    func cacheProducts(_ products: Products) {
        DiskCacheStore.shared.saveEntry(object: products, for: productsCachingKey)
    }
}



