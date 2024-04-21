//
//  ProductDetailInteractor.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 15.04.2024.
//

import Foundation

protocol ProductDetailInteractorProtocol: AnyObject {
    func addProductToCart(_ product: Product)
    func removeProductFromCart(_ product: Product)
    func updateProductCounter(_ product: Product, counter: Int)
    func getProductCounter(_ product: Product) -> Int
    func getTotalPrice(for product: Product) -> Double
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func updateTotalPriceLabel(_ price: Double)
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    weak var presenter: ProductDetailInteractorOutputProtocol?
    var basketManager = BasketManager.shared

    func addProductToCart(_ product: Product) {
        basketManager.addProduct(product)
        let totalPrice = basketManager.calculateTotalPrice()
        presenter?.updateTotalPriceLabel(totalPrice)
    }

    func removeProductFromCart(_ product: Product) {
        basketManager.removeProduct(product)
        let totalPrice = basketManager.calculateTotalPrice()
        presenter?.updateTotalPriceLabel(totalPrice)
    }

    func updateProductCounter(_ product: Product, counter: Int) {
        let currentCounter = basketManager.getBasket()[product] ?? 0
        let newCounter = max(0, currentCounter + counter)

        if newCounter > currentCounter {
            basketManager.addProduct(product)
        } else if newCounter < currentCounter {
            basketManager.removeProduct(product)
        } else {
            return
        }
        let totalPrice = basketManager.calculateTotalPrice()
        presenter?.updateTotalPriceLabel(totalPrice)
    }

    func getProductCounter(_ product: Product) -> Int {
        return basketManager.getBasket()[product] ?? 0
    }

    func getTotalPrice(for product: Product) -> Double {
        basketManager.loadBasketFromUserDefaults()
        return basketManager.calculateTotalPrice()
    }
}
