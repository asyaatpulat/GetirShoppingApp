//
//  ProductDetailPresenterTests.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class ProductDetailPresenterTests: XCTestCase {
    var presenter: ProductDetailPresenter!
    var mockInteractor: MockProductDetailInteractor!
    var mockRouter: MockProductDetailRouter!
    var mockView: MockProductDetailViewController!

    override func setUp() {
        super.setUp()
        presenter = ProductDetailPresenter()
        mockInteractor = MockProductDetailInteractor()
        mockRouter = MockProductDetailRouter()
        mockView = MockProductDetailViewController()
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
        presenter.view = mockView
    }

    override func tearDown() {
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
        mockView = nil
        super.tearDown()
    }

    func test_DidAddProduct_Called() {
        let product = getProduct()
        presenter.didAddProduct(product)

        XCTAssertTrue(mockInteractor.addProductToCartCalled, "addProductToCart should be called on the interactor")
    }

    func test_DidAddProduct_ProductAddedSuccess() {
        let product = getProduct()
        presenter.didAddProduct(product)

        XCTAssertEqual(mockInteractor.productCounter, 1, "Product counter should be incremented by 1")
    }

    func test_DidRemoveProduct_ProductRemovedSuccess() {
        let product = getProduct()
        presenter.didRemoveProduct(product)

        XCTAssertEqual(mockInteractor.productCounter, -1, "Product counter should be decremented by 1")
    }

    func test_DidRemoveProduct_Called() {
        let product = getProduct()
        presenter.didRemoveProduct(product)

        XCTAssertTrue(mockInteractor.removeProductFromCartCalled, "removeProductFromCart should be called on the interactor")
    }

    func test_DidTapCart() {
        presenter.didTapCart()

        XCTAssertTrue(mockRouter.navigateToProductBasketCalled, "navigateToProductBasket should be called on the router")
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
