//
//  ProductImageView.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 11.04.2024.
//

import Foundation
import UIKit

class ProductImageView: UIImageView {

    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let borderWidth: CGFloat = 1
        static let borderColor = UIColor.bgPrimarySubtle.cgColor
    }

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = Constants.borderColor
    }
}
