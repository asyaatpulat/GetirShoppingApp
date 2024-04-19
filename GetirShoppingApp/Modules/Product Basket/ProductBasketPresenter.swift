//
//  ProductBasketPresenter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 19.04.2024.
//

import Foundation

protocol ProductBasketPresenterProtocol: AnyObject {
    var view: ProductBasketViewControllerProtocol? { get set }
    var interactor: ProductBasketInteractorProtocol? { get set }
    var router: ProductBasketRouterProtocol? { get set }
    
    func fetchSuggestedProducts()
    func loadBasketData()
    func updatedTotalPrice(_ totalPrice: Double)
    func addProductToBasket(_ product: Product)
    func updateProductCounter(_ product: Product, counter: Int)
    func getProductCounter(_ product: Product) -> Int
    func clearBasket()    
}

final class ProductBasketPresenter {
    weak var view: ProductBasketViewControllerProtocol?
    var interactor: ProductBasketInteractorProtocol?
    var router: ProductBasketRouterProtocol?
}

extension ProductBasketPresenter: ProductBasketPresenterProtocol {
    func fetchSuggestedProducts() {
        interactor?.fetchSuggestedProducts()
    }
    
    func loadBasketData() {
        interactor?.loadBasketData()
        interactor?.fetchTotalPrice()
    }
    
    func fetchTotalPrice() {
        interactor?.fetchTotalPrice()
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
    
    func clearBasket() {
        interactor?.clearBasket()
    }
}

extension ProductBasketPresenter: ProductBasketInteractorOutputProtocol {
    func updatedProductsInBasket(_ products: [Product]) {
            view?.reloadNewProducts(products)
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
    
    func loadedBasketDataOutput(result: [Product]) {
        DispatchQueue.main.async {
            self.view?.reloadProducts(result)
        }
    }
    
    func updatedTotalPrice(_ totalPrice: Double) {
        view?.updateTotalPriceLabel(totalPrice)
    }
    
}
