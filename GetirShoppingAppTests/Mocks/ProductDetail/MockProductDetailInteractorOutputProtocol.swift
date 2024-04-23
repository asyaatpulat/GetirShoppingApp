//
//  MockProductDetailInteractorOutputProtocol.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductDetailInteractorOutput: ProductDetailInteractorOutputProtocol {
    var updateTotalPriceLabelCalled = false
    var updateTotalPriceLabelCalledWith: Double?

    func updateTotalPriceLabel(_ price: Double) {
        updateTotalPriceLabelCalled = true
        updateTotalPriceLabelCalledWith = price
    }
}
