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
}

protocol ProductListingInteractorOutputProtocol: AnyObject {
    func fetchProductsOutput(result: [Product])
    func fetchSuggestedProductsOutput(result: [Product])
    func fetchProductsFailed(error: Error)
}

final class ProductListingInteractor: ProductListingInteractorProtocol {
    
    weak var presenter: ProductListingInteractorOutputProtocol?
    var networkManager: NetworkManager
    
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
}

