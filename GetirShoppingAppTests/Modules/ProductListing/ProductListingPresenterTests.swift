//
//  ProductListingPresenterTests.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 23.04.2024.
//

import XCTest
@testable import GetirShoppingApp

class ProductListingPresenterTests: XCTestCase {

    var presenter: ProductListingPresenter!
    var mockInteractor: MockProductListingInteractor!
    var mockRouter: MockProductListingRouter!
    var mockView: MockProductListingViewController!

    override func setUp() {
        super.setUp()
        mockInteractor = MockProductListingInteractor()
        mockRouter = MockProductListingRouter()
        mockView = MockProductListingViewController()
        presenter = ProductListingPresenter()
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

    func test_FetchAllProducts_Success() {
        let products = [Product(id: "6540f93a48e4bd7bf4940ffd",
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
                                thumbnailURL: nil)]

        mockInteractor.fetchProductsCompletion?(.success(products))
        mockInteractor.fetchSuggestedProductsCompletion?(.success(products))
        presenter.fetchAllProducts()

        XCTAssertTrue(mockInteractor.fetchProductsCalled)
        XCTAssertTrue(mockInteractor.fetchSuggestedProductsCalled)
    }

    func test_FetchAllProducts_Failure() {
        let error = NSError(domain: "TestError", code: 500, userInfo: nil)

        mockInteractor.fetchProductsCompletion?(.failure(error))
        mockInteractor.fetchSuggestedProductsCompletion?(.failure(error))
        presenter.fetchAllProducts()

        XCTAssertTrue(mockInteractor.fetchProductsCalled)
        XCTAssertTrue(mockInteractor.fetchSuggestedProductsCalled)
    }

    func test_DidSelectProduct() {
        let product = getProduct()
        presenter.didSelectProduct(product)

        XCTAssertTrue(mockRouter.navigateToProductDetailCalled)
    }

    func test_DidTapCart() {
        presenter.didTapCart()

        XCTAssertTrue(mockRouter.navigateToProductBasketCalled)
    }

    func test_AddProductToBasket_AddedSuccess() {
        let product = getProduct()
        presenter.addProductToBasket(product)

        XCTAssertTrue(mockInteractor.addProductToBasketCalled)
        XCTAssertEqual(mockInteractor.productCounter, 1, "Product counter should be incremented by 1")
    }

    func test_UpdateProductCounter_UpdatedSuccess() {
        let product = getProduct()
        presenter.updateProductCounter(product, counter: 1)

        XCTAssertTrue(mockInteractor.updateProductCounterCalled)
        XCTAssertEqual(mockInteractor.productCounter, 1, "Product counter should be incremented by 1")
    }

    func test_GetProductCounter() {
        let product = getProduct()
        _ = presenter.getProductCounter(product)

        XCTAssertTrue(mockInteractor.getProductCounterCalled)
    }

    func test_FetchTotalPrice() {
        presenter.fetchTotalPrice()

        XCTAssertTrue(mockInteractor.fetchTotalPriceCalled)
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
