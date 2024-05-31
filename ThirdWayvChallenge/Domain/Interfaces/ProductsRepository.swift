//
//  ProductsRepository.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

protocol ProductsRepository {
    func fetchProducts(shouldCache: Bool, completionHandler: @escaping CompletionHandler)
}
