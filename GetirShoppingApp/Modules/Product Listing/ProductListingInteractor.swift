//
//  ProductListingInteractor.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 13.04.2024.
//

import Foundation

protocol ProductListingInteractorProtocol: AnyObject {
    var presenter: ProductListingInteractorOutputProtocol? { get set }
    func fetchProducts()
    func fetchSuggestedProducts()
    func addProductToBasket(_ product: Product)
    func updateProductCounter(_ product: Product, counter: Int)
    func getProductCounter(_ product: Product) -> Int
    func fetchTotalPrice()
}

protocol ProductListingInteractorOutputProtocol: AnyObject {
    func fetchProductsOutput(result: [Product])
    func fetchSuggestedProductsOutput(result: [Product])
    func fetchProductsFailed(error: Error)
    func updateTotalPrice(_ totalPrice: Double)
}

final class ProductListingInteractor: ProductListingInteractorProtocol {
    
    weak var presenter: ProductListingInteractorOutputProtocol?
    var networkManager: NetworkManager
    var basketManager = BasketManager.shared
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchProducts() {
        let resource = Resource<[ProductResponse]>(url: .products)
        networkManager.fetchData(resource: resource) { [weak self] result in
            switch result {
            case .success(let productResponses):
                let products = productResponses.first?.products ?? []
                self?.presenter?.fetchProductsOutput(result: products)
            case .failure(let error):
                self?.presenter?.fetchProductsFailed(error: error)
            }
        }
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
    
    func addProductToBasket(_ product: Product) {
        basketManager.addProduct(product)
        presenter?.updateTotalPrice(basketManager.calculateTotalPrice())
    }
    
    func updateProductCounter(_ product: Product, counter: Int) {
        guard let currentCounter = basketManager.getBasket()[product] else { return }
        let newCounter = max(0, currentCounter + counter)
        
        if newCounter > currentCounter {
            basketManager.addProduct(product)
        } else if newCounter < currentCounter {
            basketManager.removeProduct(product)
        }
        presenter?.updateTotalPrice(basketManager.calculateTotalPrice())
    }
    
    func getProductCounter(_ product: Product) -> Int {
       // basketManager.loadBasketFromUserDefaults()
        return basketManager.getBasket()[product] ?? 0
    }
    
    func fetchTotalPrice() {
        let totalPrice = basketManager.calculateTotalPrice()
        presenter?.updateTotalPrice(totalPrice)
    }
}

