//
//  MockProductDetailRouter.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductDetailRouter: ProductDetailRouterProtocol {
    var navigateToProductBasketCalled = false

    func navigateToProductBasket() {
        navigateToProductBasketCalled = true
    }
}
