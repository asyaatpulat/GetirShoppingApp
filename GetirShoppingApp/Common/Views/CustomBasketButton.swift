//
//  CustomBasketButton.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 16.04.2024.
//

import Foundation

import UIKit
import SnapKit

class CustomBasketButton: UIButton {

    private enum Constants {
        static let shadowOpacity: Float = 1
        static let cornerRadius: CGFloat = 8
        static let labelText = "Siparişi Tamamla"

        enum Font {
            static let textLabel = UIFont.openSansBold(ofSize: 14)
            static let priceLabel = UIFont.openSansBold(ofSize: 20)
        }

        enum Color {
            static let textColorPrimary = UIColor.textPrimary
            static let containerColor = UIColor.bgLight
            static let backgroundColor = UIColor.bgPrimarySubtle
            static let labelColor = UIColor.bgPrimary
        }
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = Constants.Color.containerColor
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.labelText
        label.font = Constants.Font.textLabel
        label.textColor = UIColor.textLight
        label.textAlignment = .center
        label.backgroundColor = Constants.Color.labelColor
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.priceLabel
        label.textColor = Constants.Color.textColorPrimary
        label.textAlignment = .center
        label.backgroundColor = Constants.Color.containerColor
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
        containerView.addSubview(textLabel)
        containerView.addSubview(priceLabel)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }

        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(containerView)
        }

        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(textLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(116)
        }
    }

    func updateTotalPriceLabel(_ totalPrice: Double) {
        priceLabel.text = "₺\(String(format: "%.2f", totalPrice))"
    }
}
