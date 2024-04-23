//
//  BasketManagerTests.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class MockBasketManager: BasketManagerProtocol {

    var addProductCalled = false
    var removeProductCalled = false
    var calculateTotalPriceCalled = false
    var getProductCountCalled = false
    var clearBasketCalled = false
    var saveBasketToUserDefaultsCalled = false
    var loadBasketFromUserDefaultsCalled = false
    var products: [Product] = []

    func addProduct(_ product: Product) {
        addProductCalled = true
        products.append(product)
    }

    func removeProduct(_ product: Product) {
        removeProductCalled = true
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products.remove(at: index)
        }
    }

    func calculateTotalPrice() -> Double {
        calculateTotalPriceCalled = true
        var totalPrice = 0.0
        for product in products {
            totalPrice += product.price ?? 0.0
        }
        return totalPrice
    }

    func getProductCount(_ product: Product) -> Int? {
        getProductCountCalled = true
        return products.filter { $0.id == product.id }.count
    }

    func getBasket() -> [Product: Int] {
        var basketDict: [Product: Int] = [:]
        for product in products {
            if let count = basketDict[product] {
                basketDict[product] = count + 1
            } else {
                basketDict[product] = 1
            }
        }
        return basketDict
    }

    func clearBasket() {
        clearBasketCalled = true
        products.removeAll()
    }

    func saveBasketToUserDefaults() {
        saveBasketToUserDefaultsCalled = true
    }

    func loadBasketFromUserDefaults() {
        loadBasketFromUserDefaultsCalled = true
    }
}
