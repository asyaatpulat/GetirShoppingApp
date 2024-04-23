//
//  MockProductDetailInteractor.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductDetailInteractor: ProductDetailInteractorProtocol {
    var presenter: ProductDetailInteractorOutputProtocol?
    var basketManager: BasketManagerProtocol = BasketManager()

    var addProductToCartCalled = false
    var removeProductFromCartCalled = false
    var updateProductCounterCalled = false
    var getProductCounterCalled = false
    var getTotalPriceCalled = false
    var productCounter = 0

    func addProductToCart(_ product: Product) {
        addProductToCartCalled = true
        productCounter += 1
    }

    func removeProductFromCart(_ product: Product) {
        removeProductFromCartCalled = true
        productCounter -= 1
    }

    func updateProductCounter(_ product: Product, counter: Int) {
        updateProductCounterCalled = true
    }

    func getProductCounter(_ product: Product) -> Int {
        getProductCounterCalled = true
        return 0
    }

    func getTotalPrice(for product: Product) -> Double {
        getTotalPriceCalled = true
        return 0.0
    }
}
