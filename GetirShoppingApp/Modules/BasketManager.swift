//
//  BasketManager.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 17.04.2024.
//

import Foundation

class BasketManager {
    
    static let shared = BasketManager()
    
    private var basket: [Product: Int] = [:]
    
    func addProduct(_ product: Product) {
        if let counter = basket[product] {
            basket[product] = counter + 1
        } else {
            basket[product] = 1
        }
    }
    
    func removeProduct(_ product: Product) {
        if let counter = basket[product] {
            if counter > 1 {
                basket[product] = counter - 1
            } else {
                basket.removeValue(forKey: product)
            }
        }
    }
    
    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        for (product, counter) in basket {
            if let price = product.price {
                totalPrice += price * Double(counter)
            }
        }
        return totalPrice
    }
    
    func clearBasket() {
        basket.removeAll()
    }
    
    func getBasket() -> [Product: Int] {
        return basket
    }
}
