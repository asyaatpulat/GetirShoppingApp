//
//  MockProductListingInteractor.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductListingInteractor: ProductListingInteractorProtocol {

    var presenter: ProductListingInteractorOutputProtocol?
    var basketManager: BasketManagerProtocol = MockBasketManager()

    var fetchProductsCalled = false
    var fetchSuggestedProductsCalled = false
    var addProductToBasketCalled = false
    var updateProductCounterCalled = false
    var getProductCounterCalled = false
    var fetchTotalPriceCalled = false
    var productCounter: Int = 0

    var fetchProductsCompletion: ((Result<[Product], Error>) -> Void)?
    var fetchSuggestedProductsCompletion: ((Result<[Product], Error>) -> Void)?

    func fetchProducts() {
        fetchProductsCalled = true
        fetchProductsCompletion?(.success([]))
    }

    func fetchSuggestedProducts() {
        fetchSuggestedProductsCalled = true
        fetchSuggestedProductsCompletion?(.success([]))
    }

    func addProductToBasket(_ product: Product) {
        addProductToBasketCalled = true
        productCounter += 1
    }

    func updateProductCounter(_ product: Product, counter: Int) {
        updateProductCounterCalled = true
        productCounter += counter
    }

    func getProductCounter(_ product: Product) -> Int {
        getProductCounterCalled = true
        return 0
    }

    func fetchTotalPrice() {
        fetchTotalPriceCalled = true
    }
}
