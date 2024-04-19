//
//  ProductBasketInteractor.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 19.04.2024.
//

import Foundation


protocol ProductBasketInteractorProtocol: AnyObject {
    var presenter: ProductBasketInteractorOutputProtocol? { get set }
    func fetchSuggestedProducts()
    func loadBasketData()
    func fetchTotalPrice()
}

protocol ProductBasketInteractorOutputProtocol: AnyObject {
    func fetchSuggestedProductsOutput(result: [Product])
    func fetchProductsFailed(error: Error)
    func loadedBasketDataOutput(result: [Product])
    func updatedTotalPrice(_ totalPrice: Double)
}

final class ProductBasketInteractor: ProductBasketInteractorProtocol {
    
    weak var presenter: ProductBasketInteractorOutputProtocol?
    var networkManager: NetworkManager
    var basketManager = BasketManager.shared
    
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
    
    func fetchTotalPrice() {
        let totalPrice = basketManager.calculateTotalPrice()
        presenter?.updatedTotalPrice(totalPrice)
    }
}

