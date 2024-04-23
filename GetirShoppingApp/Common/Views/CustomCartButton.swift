//
//  CustomCartView.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 15.04.2024.
//

import Foundation
import UIKit
import SnapKit

class CustomCartButton: UIButton {

    private enum Constants {
        static let shadowOpacity: Float = 1
        static let offset = CGSize(width: 0, height: 0)
        static let shadowRadius: CGFloat = 6
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1

        enum Font {
            static let label = UIFont.openSansBold(ofSize: 14)
        }

        enum Color {
            static let textColorPrimary = UIColor.textPrimary
            static let shadowColor = UIColor.productCardShadow.cgColor
            static let buttonColor = UIColor.bgLight
            static let borderColor = UIColor.bgLight.cgColor
            static let backgroundColor = UIColor.bgPrimarySubtle
        }
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderWidth = Constants.borderWidth
        view.backgroundColor = Constants.Color.buttonColor
        view.layer.borderColor = Constants.Color.borderColor
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.cart
        imageView.contentMode = .center
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.label
        label.textColor = Constants.Color.textColorPrimary
        label.textAlignment = .center
        label.backgroundColor = Constants.Color.backgroundColor
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(textLabel)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(91)
        }

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(34)
        }

        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(57)
        }
    }

    func updateTotalPriceLabel(_ totalPrice: Double) {
        textLabel.text = "₺\(String(format: "%.2f", totalPrice))"
    }
}
