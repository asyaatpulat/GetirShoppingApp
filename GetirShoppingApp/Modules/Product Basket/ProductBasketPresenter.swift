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
    
}
