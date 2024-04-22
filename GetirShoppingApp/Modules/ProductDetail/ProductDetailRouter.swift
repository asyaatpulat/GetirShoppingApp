//
//  ProductDetailRouter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 15.04.2024.
//

import Foundation
import UIKit

protocol ProductDetailRouterProtocol: AnyObject {
    func navigateToProductBasket()
}

final class ProductDetailRouter: ProductDetailRouterProtocol {
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

    func navigateToProductBasket() {
        guard let productBasketViewController = ProductBasketRouter.createModule() as? ProductBasketViewController else {
            return
        }
        let nav = UINavigationController(rootViewController: productBasketViewController)
        nav.modalPresentationStyle = .fullScreen
        view?.present(nav, animated: true, completion: nil)
    }
}
