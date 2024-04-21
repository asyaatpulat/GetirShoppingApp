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

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.bgLight
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Siparişi Tamamla"
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.textColor = UIColor.textLight
        label.textAlignment = .center
        label.backgroundColor = UIColor.bgPrimary
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
       // label.text = "₺0,00"
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.textColor = UIColor.textPrimary
        label.textAlignment = .center
        label.backgroundColor = UIColor.bgLight
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
