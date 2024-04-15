//
//  ProductListingPresenter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 13.04.2024.
//


import Foundation

protocol ProductListingPresenterProtocol: AnyObject {
    var view: ProductListingViewControllerProtocol? { get set }
    var interactor: ProductListingInteractorProtocol? { get set }
    var router: ProductListingRouterProtocol? { get set }
    
    func fetchProducts()
    func fetchSuggestedProducts()
    func didSelectProduct(_ product: Product)
}

final class ProductListingPresenter {
    weak var view: ProductListingViewControllerProtocol?
    var interactor: ProductListingInteractorProtocol?
    var router: ProductListingRouterProtocol?
}

extension ProductListingPresenter: ProductListingPresenterProtocol {
    func fetchProducts() {
        interactor?.fetchProducts()
    }
    
    func fetchSuggestedProducts() {
        interactor?.fetchSuggestedProducts()
    }
    
    func didSelectProduct(_ product: Product) {
        router?.navigateToProductDetail(with: product)
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
}
