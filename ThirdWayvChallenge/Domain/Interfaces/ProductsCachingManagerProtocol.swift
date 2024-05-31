//
//  ProductsCachingManagerProtocol.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation

protocol ProductsCachingManagerProtocol {
    func fetchProducts() -> Products
    func cacheProducts(_ products: Products)
}
