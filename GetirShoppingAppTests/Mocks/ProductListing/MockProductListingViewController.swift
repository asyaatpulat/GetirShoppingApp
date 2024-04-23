//
//  MockProductListingViewController.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductListingViewController: ProductListingViewControllerProtocol {

    var reloadProductsCalled = false
    var reloadSuggestedProductsCalled = false
    var fetchProductsFailedCalled = false
    var updateTotalPriceLabelCalled = false

    func reloadProducts(_ products: [Product]) {
        reloadProductsCalled = true
    }

    func reloadSuggestedProducts(_ suggestedProducts: [Product]) {
        reloadSuggestedProductsCalled = true
    }

    func fetchProductsFailed(error: Error) {
        fetchProductsFailedCalled = true
    }

    func updateTotalPriceLabel(_ totalPrice: Double) {
        updateTotalPriceLabelCalled = true
    }
}
