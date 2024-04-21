//
//  ProductDetailPresenter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 15.04.2024.
//

import Foundation

protocol ProductDetailPresenterProtocol: AnyObject {
    var view: ProductDetailViewControllerProtocol? { get set}
    var interactor: ProductDetailInteractorProtocol? {get set}
    var router: ProductDetailRouterProtocol? {get set}

    func didAddProduct(_ product: Product)
    func didRemoveProduct(_ product: Product)
    func increaseProductCounter()
    func decreaseProductCounter()
    func updateTotalPriceLabel(_ price: Double)
    func getProductCounter(_ product: Product) -> Int
    func fetchTotalPrice()
    func didTapCart()
    func updateItemCounter()
}

final class ProductDetailPresenter {
    weak var view: ProductDetailViewControllerProtocol?
    var interactor: ProductDetailInteractorProtocol?
    var router: ProductDetailRouterProtocol?

    var product: Product? {
        didSet {
            if let product = product {
                configureProductDetails(with: product)
            }
        }
    }
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    func didRemoveProduct(_ product: Product) {
        interactor?.removeProductFromCart(product)
    }

    func didAddProduct(_ product: Product) {
        interactor?.addProductToCart(product)
    }

    func increaseProductCounter() {
        guard let product = product else { return }
        interactor?.updateProductCounter(product, counter: 1)
    }

    func decreaseProductCounter() {
        guard let product = product else { return }
        interactor?.updateProductCounter(product, counter: -1)
    }

    func getProductCounter(_ product: Product) -> Int {
        return interactor?.getProductCounter(product) ?? 0
    }

    func fetchTotalPrice() {
        guard let product = product else { return }
        let totalPrice = interactor?.getTotalPrice(for: product) ?? 0
        view?.updateTotalPriceLabel(totalPrice)
    }

    func updateItemCounter() {
        guard let product = product else { return }
        let itemCounter = interactor?.getProductCounter(product) ?? 0
        view?.updateItemCounter(itemCounter)
    }

    func didTapCart() {
        router?.navigateToProductBasket()
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func configureProductDetails(with product: Product) {
        view?.displayProductDetails(with: product)
    }

    func updateTotalPriceLabel(_ price: Double) {
        view?.updateTotalPriceLabel(price)
    }
}
