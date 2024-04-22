//
//  ProductBasketRouter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 19.04.2024.
//

import Foundation
import UIKit

protocol ProductBasketRouterProtocol: AnyObject {
}

final class ProductBasketRouter: ProductBasketRouterProtocol {
    private weak var view: UIViewController?

    init(view: UIViewController? = nil) {
        self.view = view
    }

    static func createModule() -> UIViewController {
        let productBasketViewController = ProductBasketViewController()
        let presenter = ProductBasketPresenter()
        let networkManager = NetworkManager()
        let router = ProductBasketRouter(view: productBasketViewController)
        let interactor = ProductBasketInteractor(networkManager: networkManager)
        productBasketViewController.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = productBasketViewController
        presenter.router = router
        return productBasketViewController
    }
}
