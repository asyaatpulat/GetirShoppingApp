//
//  Section.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 22.04.2024.
//

import Foundation

enum Section: Int, CaseIterable {
    case suggestedProducts
    case products
}

extension Section {
    var reuseIdentifier: String {
        switch self {
        case .suggestedProducts:
            return "SuggestedProductCell"
        case .products:
            return "ProductCell"
        }
    }
}

enum BasketSection: Int, CaseIterable {
    case products
    case suggestedProducts
}

extension BasketSection {
    var reuseId: String {
        switch self {
        case .products:
            return "ProductBasketCell"
        case .suggestedProducts:
            return "ProductCell"
        }
    }
}
