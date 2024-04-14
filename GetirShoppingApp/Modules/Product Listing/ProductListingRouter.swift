//
//  ProductListingRouter.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 13.04.2024.
//

import Foundation
import UIKit

protocol ProductListingRouterProtocol: AnyObject {
    
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
}

