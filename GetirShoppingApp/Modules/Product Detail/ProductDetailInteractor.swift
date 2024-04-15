//
//  ProductDetailInteractor.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 15.04.2024.
//

import Foundation

protocol ProductDetailInteractorProtocol: AnyObject {
    
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    weak var presenter: ProductDetailInteractorOutputProtocol?
}
