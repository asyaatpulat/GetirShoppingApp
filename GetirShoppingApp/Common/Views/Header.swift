//
//  Header.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 22.04.2024.
//

import Foundation
import UIKit

class Header: UICollectionReusableView {

    private enum Constants {
        static let labelText = "Önerilen Ürünler"
        static let labelFont = UIFont.openSansSemiBold(ofSize: 12)
    }

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = Constants.labelText
        label.font = Constants.labelFont
        addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
