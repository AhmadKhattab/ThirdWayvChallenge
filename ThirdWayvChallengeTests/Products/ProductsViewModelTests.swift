//
//  ProductsViewModelTests.swift
//  ThirdWayvChallengeTests
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import XCTest
@testable import ThirdWayvChallenge

final class ProductsViewModelTests: XCTestCase {
    // MARK: - properties
    var sut: ProductsViewModel!
    var productsRepositoryFake: ProductsRepository!
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        productsRepositoryFake = DefaultProductsRepositoryFake()
        sut = ProductsViewModel(with: productsRepositoryFake)
    }
    override func tearDown() {
        sut = nil
        productsRepositoryFake = nil
        super.tearDown()
    }
    // MARK: - Test Cases
    func test_fetchProducts_willReturnThreeItems() throws {
        let expectedProductsNumber = 3
        sut.productsObservable.observe(on: self) { products in
            // Then
            XCTAssertEqual(expectedProductsNumber, products.count)
        }
        // When
        sut.fetchProducts(shouldCache: true)
    }
}
