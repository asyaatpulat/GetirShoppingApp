//
//  ProductListingRouter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 13.04.2024.
//

import Foundation
import UIKit

protocol ProductListingRouterProtocol: AnyObject {
    func navigateToProductDetail(with: Product)
    func navigateToProductBasket()
}

class ProductListingRouter: ProductListingRouterProtocol {
    private weak var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
    
    static func createModule() -> UIViewController {
        let productListingViewController = ProductListingViewController()
        let presenter = ProductListingPresenter()
        let networkManager = NetworkManager()
        let router = ProductListingRouter(view: productListingViewController)
        let interactor = ProductListingInteractor(networkManager: networkManager)
        productListingViewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = productListingViewController
        presenter.router = router
        return productListingViewController
    }
    
    func navigateToProductDetail(with product: Product) {
        guard let productDetailViewController = ProductDetailRouter.createModule(with: product) as? ProductDetailViewController else {
            return
        }
        let nav = UINavigationController(rootViewController: productDetailViewController)
        nav.modalPresentationStyle = .fullScreen
        view?.present(nav, animated: true, completion: nil)
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
