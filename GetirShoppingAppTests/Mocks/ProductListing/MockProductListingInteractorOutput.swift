//
//  MockProductListingInteractorOutput.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductListingInteractorOutput: ProductListingInteractorOutputProtocol {

    var fetchProductsOutputCalled = false
    var fetchSuggestedProductsOutputCalled = false
    var fetchProductsFailedCalled = false
    var updateTotalPriceCalled = false

    var fetchedProducts: [Product]?
    var suggestedProducts: [Product]?
    var fetchProductsFailedError: Error?
    var totalPrice: Double?

    func fetchProductsOutput(result: [Product]) {
        fetchProductsOutputCalled = true
        fetchedProducts = result
    }

    func fetchSuggestedProductsOutput(result: [Product]) {
        fetchSuggestedProductsOutputCalled = true
        suggestedProducts = result
    }

    func fetchProductsFailed(error: Error) {
        fetchProductsFailedCalled = true
        fetchProductsFailedError = error
    }

    func updateTotalPrice(_ totalPrice: Double) {
        updateTotalPriceCalled = true
        self.totalPrice = totalPrice
    }
}
