//
//  SuggestedProductsResponse.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 12.04.2024.
//

import Foundation

struct Product: Codable, Hashable {
    let id: String?
    let imageURL: String?
    let price: Double?
    let name: String?
    let priceText: String?
    let shortDescription: String?
    let category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
    let attribute: String?
    let thumbnailURL: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ProductResponse: Codable {
    let id: String?
    let name: String?
    let productCount: Int?
    let products: [Product]?
}
