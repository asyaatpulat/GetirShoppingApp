//
//  MockProductListingRouter.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductListingRouter: ProductListingRouterProtocol {

    var navigateToProductDetailCalled = false
    var navigateToProductBasketCalled = false

    func navigateToProductDetail(with product: Product) {
        navigateToProductDetailCalled = true
    }

    func navigateToProductBasket() {
        navigateToProductBasketCalled = true
    }
}
