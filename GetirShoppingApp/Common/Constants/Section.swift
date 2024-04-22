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
