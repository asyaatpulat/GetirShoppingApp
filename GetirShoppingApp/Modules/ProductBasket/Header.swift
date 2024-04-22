//
//  Header.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 22.04.2024.
//

import Foundation
import UIKit

class Header: UICollectionReusableView {

    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Önerilen Ürünler"
        label.font = UIFont.openSansSemiBold(ofSize: 12)
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
