//
//  DefaultProductsRepositoryFake.swift
//  ThirdWayvChallengeTests
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import Foundation
@testable import ThirdWayvChallenge

class DefaultProductsRepositoryFake: ProductsRepository {
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    private let cachingManager: ProductsCachingManagerProtocol
    // MARK: - Initializer(s)
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         cachingManager: ProductsCachingManagerProtocol = ProductsCachingManager()) {
        self.networkManager = networkManager
        self.cachingManager = cachingManager
    }
    
    func fetchProducts(shouldCache: Bool, completionHandler: @escaping CompletionHandler) {
        let products = getProductsFromJson()
        completionHandler(.success(products.toDomain()))
    }
}

func getProductsFromJson() -> Products {
    let productsJson = """
    [
      {
        "id": 1,
        "productDescription": "1 - Lorem ipsum oo czsqotentbrukdkgutopykxslppqdfyecqnyvgevorbvfizvlz zsbycwbeumtttk",
        "image": {
          "width": 150,
          "height": 331,
          "url": "https://i.picsum.photos/id/1010/150/301.jpg?hmac=jOdmvDoGwNveVpbng2Z-dVzDjqBu97vauW0MUVvYeK0"
        },
        "price": 754
      },
      {
        "id": 2,
        "productDescription": "2 - Lorem ipsum boqxjhitlihdzpadydtazicjfqjoqg swjsdibmq",
        "image": {
          "width": 150,
          "height": 308,
          "url": "https://i.picsum.photos/id/62/150/308.jpg?hmac=v--t36mvaUNgPphIzLhhqYT3ShCWMZ51V358xiX8dO4"
        },
        "price": 935
      },
      {
        "id": 3,
        "productDescription": "3 - Lorem ipsum tdgd mtyponmicclpoiyccagemfcrka",
        "image": {
          "width": 150,
          "height": 242,
          "url": "https://i.picsum.photos/id/1026/150/242.jpg?hmac=CiQC8SaSTucRn_gOkud_cA-FjNA_-gxyeap9d3E5iWM"
        },
        "price": 681
      }
    ]
    """
    let productsData = Data(productsJson.utf8)
    let products = try? JSONDecoder().decode(Products.self, from: productsData)
    return products ?? []
}
