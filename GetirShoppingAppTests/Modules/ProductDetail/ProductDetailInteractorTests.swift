//
//  ProductDetailInteractorTests.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class ProductDetailInteractorTests: XCTestCase {
    var interactor: ProductDetailInteractorProtocol!
    var mockPresenter: MockProductDetailInteractorOutput!
    var mockBasketManager: MockBasketManager!

    override func setUp() {
        super.setUp()
        interactor = ProductDetailInteractor()
        mockPresenter = MockProductDetailInteractorOutput()
        interactor.presenter = mockPresenter
        mockBasketManager = MockBasketManager()
        interactor.basketManager = mockBasketManager
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockBasketManager = nil
        super.tearDown()
    }

    func test_AddProductToCart_ProductAddSuccess() {
        let product = getProduct()
        interactor.addProductToCart(product)

        XCTAssertTrue(mockBasketManager.products.contains(where: { $0.id == product.id}))
    }

    func test_AddProductToCart_Called() {
        let product = getProduct()
        interactor.addProductToCart(product)

        XCTAssertTrue(mockBasketManager.addProductCalled, "addProduct should be called on the basket manager")
        XCTAssertTrue(mockPresenter.updateTotalPriceLabelCalled, "updateTotalPriceLabel should be called on the presenter")
    }

    func test_RemoveProductFromCart_ProductRemoveSuccess() {
        let product = getProduct()

        interactor.removeProductFromCart(product)

        XCTAssertFalse(mockBasketManager.products.contains(where: { $0.id == product.id }), "Product should be removed from the basket manager")
    }

    func test_RemoveProductFromCart_Called() {
        let product = getProduct()

         interactor.removeProductFromCart(product)

        XCTAssertTrue(mockBasketManager.removeProductCalled, "removeProduct should be called on the basket manager")
        XCTAssertTrue(mockPresenter.updateTotalPriceLabelCalled, "updateTotalPriceLabel should be called on the presenter")
    }

    func test_UpdateProductCounter() {
        let product = getProduct()

         interactor.updateProductCounter(product, counter: 1)

        XCTAssertTrue(mockBasketManager.addProductCalled, "addProduct should be called on the basket manager")
        XCTAssertTrue(mockPresenter.updateTotalPriceLabelCalled, "updateTotalPriceLabel should be called on the presenter")
    }

    func test_GetProductCounter() {
        let product = getProduct()

        _ = interactor.getProductCounter(product)

        XCTAssertTrue(mockBasketManager.getProductCountCalled, "getProductCount should be called on the basket manager")
    }

    func test_GetTotalPrice() {
        let product = getProduct()

        _ = interactor.getTotalPrice(for: product)

        XCTAssertTrue(mockBasketManager.calculateTotalPriceCalled, "calculateTotalPrice should be called on the basket manager")
    }

    private func getProduct() -> Product {
        let product =  Product(
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
            thumbnailURL: nil)
        return product
    }
}
