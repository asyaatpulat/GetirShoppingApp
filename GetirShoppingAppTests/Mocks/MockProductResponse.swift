//
//  MockProductResponse.swift
//  GetirShoppingAppTests
//
//  Created by Asya Atpulat on 22.04.2024.
//

import XCTest
@testable import GetirShoppingApp

struct MockProductResponse: Decodable {
    var products: [Product] = [
        Product(
            id: "6540f93a48e4bd7bf4940ffd",
            imageURL: "https://market-product-images-cdn.getirapi.com/product/dee83b80-7f9a-4aea-b799-e3316b5696f1.jpg",
            price: 140.75,
            name: "Master Nut NR1 Mixed Nuts",
            priceText: "₺140,75",
            shortDescription: "140 g",
            category: nil,
            unitPrice: nil,
            squareThumbnailURL: nil,
            status: nil,
            attribute: nil,
            thumbnailURL: nil
        ),
        Product(
            id: "61dc4659b93cd396c7a742fc",
            imageURL: "https://market-product-images-cdn.getirapi.com/product/ad25df11-6d82-4a9d-8ad8-d86aa8ce1fd3.jpg",
            price: 33.6,
            name: "Doritos Risk Super Size",
            priceText: "₺33,60",
            shortDescription: nil,
            category: nil,
            unitPrice: nil,
            squareThumbnailURL: nil,
            status: nil,
            attribute: nil,
            thumbnailURL: nil
        )
    ]
}
