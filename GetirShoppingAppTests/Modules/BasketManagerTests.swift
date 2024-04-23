//
//  BasketManagerTests.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class BasketManagerTests: XCTestCase {

    var basketManager: BasketManagerProtocol = BasketManager()

    override func setUp() {
        super.setUp()
        basketManager = BasketManager.shared
        basketManager.clearBasket()
    }

    func test_AddProduct_ProductAddSuccess() {
        let product = getProduct1()
        basketManager.addProduct(product)

        XCTAssertEqual(basketManager.getProductCount(product), 1)
    }

    func test_RemoveProduct_ProductRemoveSuccess() {
        let product = getProduct1()

        basketManager.addProduct(product)
        basketManager.removeProduct(product)

        XCTAssertEqual(basketManager.getProductCount(product), nil)
    }

    func test_CalculateTotalPrice_TotalPriceCalculatedSuccess() {
        let product1 = getProduct1()
        let product2 = getProduct2()

        basketManager.addProduct(product1)
        basketManager.addProduct(product2)

        let totalPrice = basketManager.calculateTotalPrice()

        XCTAssertEqual(totalPrice, 174.35)
    }

    func test_ClearBasket_ClearSuccess() {
        let product1 = getProduct1()
        let product2 = getProduct2()

        basketManager.addProduct(product1)
        basketManager.addProduct(product2)
        basketManager.clearBasket()

        XCTAssertEqual(basketManager.getBasket().isEmpty, true)
    }

    func test_SaveAndLoadBasketFromUserDefaults_Success() {
        let product = getProduct1()

        basketManager.addProduct(product)
        basketManager.saveBasketToUserDefaults()
        basketManager.loadBasketFromUserDefaults()

        XCTAssertEqual(basketManager.getProductCount(product), 1)
    }

    private func getProduct1() -> Product {
        return  Product(
            id: "6540f93a48e4bd7bf4940ffd",
            imageURL: "https://market-product-images-cdn.getirapi.com/product/dee83b80-7f9a-4aea-b799-e3316b5696f1.jpg",
            price: 140.75,
            name: "Master Nut NR1 Mixed Nuts",
            priceText: "₺140,75",
            shortDescription: "140 g",
            category: nil,
            unitPrice: nil,
            squareThumbnailURL: nil,
            status: nil,
            attribute: nil,
            thumbnailURL: nil
        )
    }

    private func getProduct2() -> Product {
        return Product(
            id: "61dc4659b93cd396c7a742fc",
            imageURL: "https://market-product-images-cdn.getirapi.com/product/ad25df11-6d82-4a9d-8ad8-d86aa8ce1fd3.jpg",
            price: 33.6,
            name: "Doritos Risk Super Size",
            priceText: "₺33,60",
            shortDescription: nil,
            category: nil,
            unitPrice: nil,
            squareThumbnailURL: nil,
            status: nil,
            attribute: nil,
            thumbnailURL: nil
        )
    }
}
