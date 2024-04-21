//
//  ProductImageView.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 11.04.2024.
//

import Foundation
import UIKit

class ProductImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "bgPrimarySubtle")?.cgColor
    }
}
