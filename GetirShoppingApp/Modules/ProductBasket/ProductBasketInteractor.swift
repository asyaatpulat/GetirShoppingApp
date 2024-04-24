//
//  ProductBasketInteractor.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 19.04.2024.
//

import Foundation

protocol ProductBasketInteractorProtocol: AnyObject {
    var presenter: ProductBasketInteractorOutputProtocol? { get set }
    var basketManager: BasketManagerProtocol { get set }

    func fetchSuggestedProducts()
    func loadBasketData()
    func fetchTotalPrice()
    func addProductToBasket(_ product: Product)
    func updateProductCounter(_ product: Product, counter: Int)
    func getProductCounter(_ product: Product) -> Int
    func clearBasket()
    func fetchedTotalPrice() -> Double
}

protocol ProductBasketInteractorOutputProtocol: AnyObject {
    func fetchSuggestedProductsOutput(result: [Product])
    func fetchProductsFailed(error: Error)
    func loadedBasketDataOutput(result: [Product])
    func updatedTotalPrice(_ totalPrice: Double)
    func updatedProductsInBasket(_ products: [Product])
}

final class ProductBasketInteractor: ProductBasketInteractorProtocol {

    weak var presenter: ProductBasketInteractorOutputProtocol?
    var networkManager: NetworkManager
    var basketManager: BasketManagerProtocol = BasketManager.shared

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchSuggestedProducts() {
        let resource = Resource<[ProductResponse]>(url: .suggestedProducts)
        networkManager.fetchData(resource: resource) { [weak self] result in
            switch result {
            case .success(let productResponses):
                let suggestedProducts = productResponses.first?.products ?? []
                self?.presenter?.fetchSuggestedProductsOutput(result: suggestedProducts)
            case .failure(let error):
                self?.presenter?.fetchProductsFailed(error: error)
            }
        }
    }

    func loadBasketData() {
        basketManager.loadBasketFromUserDefaults()
        let basket = basketManager.getBasket()
        let products = Array(basket.keys)
        presenter?.loadedBasketDataOutput(result: products)
    }

    func fetchedTotalPrice() -> Double {
        return basketManager.calculateTotalPrice()
    }

    func fetchTotalPrice() {
        let totalPrice = basketManager.calculateTotalPrice()
        presenter?.updatedTotalPrice(totalPrice)
    }

    func addProductToBasket(_ product: Product) {
        basketManager.addProduct(product)
        presenter?.updatedTotalPrice(basketManager.calculateTotalPrice())
        let updatedProducts = Array(basketManager.getBasket().keys)
        presenter?.updatedProductsInBasket(updatedProducts)
    }

    func updateProductCounter(_ product: Product, counter: Int) {
        let currentCounter = basketManager.getProductCount(product) ?? 0
        let newCounter = max(0, currentCounter + counter)
        if newCounter > currentCounter {
            basketManager.addProduct(product)
        } else if newCounter < currentCounter {
            basketManager.removeProduct(product)
        }
        presenter?.updatedTotalPrice(basketManager.calculateTotalPrice())
        let updatedProducts = Array(basketManager.getBasket().keys)
        presenter?.updatedProductsInBasket(updatedProducts)
    }

    func getProductCounter(_ product: Product) -> Int {
        return basketManager.getProductCount(product) ?? 0
    }

    func clearBasket() {
        basketManager.clearBasket()
    }
}
