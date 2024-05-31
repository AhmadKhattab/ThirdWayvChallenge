//
//  ProductsResponseDTO.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

// MARK: - Typealias
typealias Products = [Product]
// MARK: - Product
struct Product: Codable {
    let id: Int
    let productDescription: String
    let image: Image
    let price: Int
}
// MARK: - Image
struct Image: Codable {
    let width, height: Int
    let url: String
}
// MARK: - Mapping to Domain
extension Product {
    func toDomain() -> ProductDataModel {
        ProductDataModel(image: image, description: productDescription, price: "\(price)$")
    }
}
