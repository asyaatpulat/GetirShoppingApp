//
//  BasketManager.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 17.04.2024.
//

import Foundation

protocol BasketManagerProtocol: AnyObject {
    func addProduct(_ product: Product)
    func removeProduct(_ product: Product)
    func calculateTotalPrice() -> Double
    func getProductCount(_ product: Product) -> Int?
    func clearBasket()
    func getBasket() -> [Product: Int]
    func saveBasketToUserDefaults()
    func loadBasketFromUserDefaults()
}

class BasketManager: BasketManagerProtocol {

    static let shared = BasketManager()
    private var basket: [Product: Int] = [:]

    func addProduct(_ product: Product) {
        if let counter = basket[product] {
            basket[product] = counter + 1
        } else {
            basket[product] = 1
        }
        saveBasketToUserDefaults()
    }

    func removeProduct(_ product: Product) {
        if let counter = basket[product] {
            if counter > 1 {
                basket[product] = counter - 1
            } else {
                basket.removeValue(forKey: product)
            }
        }
        saveBasketToUserDefaults()
    }

    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        loadBasketFromUserDefaults()
        for (product, counter) in basket {
            if let price = product.price {
                totalPrice += price * Double(counter)
            }
        }
        return totalPrice
    }

    func getProductCount(_ product: Product) -> Int? {
        loadBasketFromUserDefaults()
        return basket[product]
    }

    func clearBasket() {
        basket.removeAll()
        saveBasketToUserDefaults()
    }

    func getBasket() -> [Product: Int] {
        return basket
    }

    func saveBasketToUserDefaults() {
        let encoder = JSONEncoder()
        if let encodedBasket = try? encoder.encode(basket) {
            UserDefaults.standard.set(encodedBasket, forKey: "basket")
        }
    }

    func loadBasketFromUserDefaults() {
        if let savedBasket = UserDefaults.standard.data(forKey: "basket") {
            let decoder = JSONDecoder()
            if let loadedBasket = try? decoder.decode([Product: Int].self, from: savedBasket) {
                basket = loadedBasket
            }
        }
    }
}
