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
}

extension ProductBasketPresenter: ProductBasketInteractorOutputProtocol {
   
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
