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
    func didAddProduct(_ product: Product) {
        //
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func configureProductDetails(with product: Product) {
        view?.displayProductDetails(with: product)
    }
}
