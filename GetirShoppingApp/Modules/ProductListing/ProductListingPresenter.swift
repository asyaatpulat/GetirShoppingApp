//
//  ProductListingPresenter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 13.04.2024.
//

import Foundation

protocol ProductListingPresenterProtocol: AnyObject {
    var view: ProductListingViewControllerProtocol? { get }
    var interactor: ProductListingInteractorProtocol? { get }
    var router: ProductListingRouterProtocol? { get }

    func fetchAllProducts()
    func didSelectProduct(_ product: Product)
    func didTapCart()
    func addProductToBasket(_ product: Product)
    func updateProductCounter(_ product: Product, counter: Int)
    func getProductCounter(_ product: Product) -> Int
}

final class ProductListingPresenter {
    weak var view: ProductListingViewControllerProtocol?
    var interactor: ProductListingInteractorProtocol?
    var router: ProductListingRouterProtocol?
}

extension ProductListingPresenter: ProductListingPresenterProtocol {

    func fetchAllProducts() {
        interactor?.fetchProducts()
        interactor?.fetchSuggestedProducts()
    }

    func didSelectProduct(_ product: Product) {
        router?.navigateToProductDetail(with: product)
    }

    func didTapCart() {
        router?.navigateToProductBasket()
    }

    func addProductToBasket(_ product: Product) {
        interactor?.addProductToBasket(product)
    }

    func updateProductCounter(_ product: Product, counter: Int) {
        interactor?.updateProductCounter(product, counter: counter)
    }

    func getProductCounter(_ product: Product) -> Int {
        interactor?.fetchTotalPrice()
        return interactor?.getProductCounter(product) ?? 0
    }

    func fetchTotalPrice() {
        interactor?.fetchTotalPrice()
    }
}

extension ProductListingPresenter: ProductListingInteractorOutputProtocol {

    func fetchProductsOutput(result: [Product]) {
        DispatchQueue.main.async {
            self.view?.reloadProducts(result)
        }
    }

    func fetchSuggestedProductsOutput(result: [Product]) {
        DispatchQueue.main.async {
            self.view?.reloadSuggestedProducts(result)
        }
    }

    func fetchProductsFailed(error: Error) {
        DispatchQueue.main.async {
            self.view?.fetchProductsFailed(error: error)
        }
    }

    func updateTotalPrice(_ totalPrice: Double) {
        view?.updateTotalPriceLabel(totalPrice)
    }
}
