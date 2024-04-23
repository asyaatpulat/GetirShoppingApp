//
//  MockProductDetailViewController.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockProductDetailViewController: ProductDetailViewControllerProtocol {
    func displayProductDetails(with product: Product) {}

    func updateTotalPriceLabel(_ price: Double) {}

    func updateItemCounter(_ count: Int) {}
}
