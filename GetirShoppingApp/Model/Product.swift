//
//  SuggestedProductsResponse.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 12.04.2024.
//

import Foundation

struct Product: Codable {
    let id, imageURL: String?
    let price: Double?
    let name, priceText: String?
    let shortDescription: String?
    let category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
    let attribute, thumbnailURL: String?
}

struct ProductResponse: Codable {
    let product: [Product]?
    let id, name: String?
    let productCount: Int?
}
