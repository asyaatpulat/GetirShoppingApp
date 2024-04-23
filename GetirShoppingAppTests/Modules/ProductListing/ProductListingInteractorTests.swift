//
//  ProductListingInteractorTests.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class ProductListingInteractorTests: XCTestCase {

    var interactor: ProductListingInteractorProtocol!
    var mockPresenter: MockProductListingInteractorOutput!
    var mockBasketManager: MockBasketManager!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockPresenter = MockProductListingInteractorOutput()
        mockBasketManager = MockBasketManager()
        mockNetworkManager = MockNetworkManager()

        interactor = ProductListingInteractor(networkManager: mockNetworkManager)
        interactor.presenter = mockPresenter
        interactor.basketManager = mockBasketManager
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockBasketManager = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func test_AddProductToBasket() {
        let product = MockProductResponse().products[0]
        interactor.addProductToBasket(product)

        XCTAssertTrue(mockBasketManager.addProductCalled, "addProduct should be called")
        XCTAssertEqual(mockPresenter.totalPrice, mockBasketManager.calculateTotalPrice(), "Total price should be updated")
    }

    func test_UpdateProductCounter_IncreaseSuccess() {
        let product = MockProductResponse().products[0]
        interactor.updateProductCounter(product, counter: 1)

        XCTAssertTrue(mockBasketManager.addProductCalled, "addProduct should be called")
        XCTAssertEqual(mockPresenter.totalPrice, mockBasketManager.calculateTotalPrice(), "Total price should be updated")
    }

    func test_UpdateProductCounter_RemoveSuccess() {
        let product = MockProductResponse().products[0]

        interactor.updateProductCounter(product, counter: 1)

        XCTAssertTrue(mockBasketManager.addProductCalled, "addProduct should be called")
        XCTAssertEqual(mockPresenter.totalPrice, mockBasketManager.calculateTotalPrice(), "Total price should be updated")

        interactor.updateProductCounter(product, counter: -1)

        XCTAssertTrue(mockBasketManager.removeProductCalled, "removeProduct should be called")
        XCTAssertEqual(mockPresenter.totalPrice, mockBasketManager.calculateTotalPrice(), "Total price should be updated")
    }

    func test_GetProductCounter() {
        let product = MockProductResponse().products[0]
        _ = interactor.getProductCounter(product)

        XCTAssertTrue(mockBasketManager.getProductCountCalled, "getProductCount should be called")
    }

    func test_FetchTotalPrice() {
        interactor.fetchTotalPrice()

        XCTAssertEqual(mockPresenter.totalPrice, mockBasketManager.calculateTotalPrice(), "Total price should be updated")
    }
}
