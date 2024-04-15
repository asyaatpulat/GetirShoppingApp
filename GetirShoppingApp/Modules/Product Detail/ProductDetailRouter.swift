//
//  ProductDetailRouter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 15.04.2024.
//

import Foundation
import UIKit

protocol ProductDetailRouterProtocol: AnyObject {
    
}


class ProductDetailRouter: ProductDetailRouterProtocol {
    private weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
    
    static func createModule(with product: Product) -> UIViewController {
        let productDetailViewController = ProductDetailViewController()
        let presenter = ProductDetailPresenter()
        let router = ProductDetailRouter(view: productDetailViewController)
        let interactor = ProductDetailInteractor()
        productDetailViewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = productDetailViewController
        presenter.router = router
        presenter.product = product

        return productDetailViewController
    }
}

