//
//  ProductBasketCell.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 16.04.2024.
//

import UIKit
import SnapKit

protocol ProductBasketCellDelegate: AnyObject {
    func updateProductCounter(for product: Product, counter: Int)
    func getProductCounter(for product: Product) -> Int
    func productDidReachZero(_ product: Product)
}

class ProductBasketCell: UICollectionViewCell, CustomStepperDelegate {

    private enum Constants {
        static let numberOfLines: Int = 1
        static let numberOfLinesProduct: Int = 2
        static let reuseIdentifier = "ProductBasketCell"

        enum Font {
            static let priceLabel = UIFont.openSansBold(ofSize: 14)
            static let productNamelabel = UIFont.openSansSemiBold(ofSize: 12)
            static let attributeLabel = UIFont.openSansSemiBold(ofSize: 12)
        }

        enum Color {
            static let textColorPrimary = UIColor.textPrimary
            static let textColorDark = UIColor.textDark
            static let textColorSecondary = UIColor.textSecondary
        }
    }

    weak var delegate: ProductBasketCellDelegate?
    var product: Product?
    private var indexPath: IndexPath?

    private lazy var containerView = UIView()
    private lazy var productImageView = ProductImageView()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.productNamelabel
        label.textColor = Constants.Color.textColorDark
        label.numberOfLines = Constants.numberOfLines
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.attributeLabel
        label.textColor = Constants.Color.textColorSecondary
        label.numberOfLines = Constants.numberOfLinesProduct
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.priceLabel
        label.textColor = Constants.Color.textColorPrimary
        label.numberOfLines = Constants.numberOfLinesProduct
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var stepper: CustomStepper = {
        let stepper = CustomStepper(orientation: .horizontal)
        stepper.delegate = self
        return stepper
    }()

    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .bgPrimarySubtle
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(attributeLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(stepper)
        addSubview(bottomBorderView)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        productImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(74)
        }

        productNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
            make.top.equalTo(containerView.snp.top).offset(8.5)
            make.trailing.equalTo(stepper.snp.leading).offset(-12)
        }

        attributeLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
            make.top.equalTo(productNameLabel.snp.bottom).offset(2)
        }

        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
            make.top.equalTo(attributeLabel.snp.bottom).offset(4)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8.5)
        }

        stepper.snp.makeConstraints { make in
            make.trailing.equalTo(containerView)
            make.centerY.equalTo(containerView)
            make.width.equalTo(102)
            make.height.equalTo(32)
        }

        bottomBorderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(containerView.snp.bottom).offset(12)
        }
    }

    func stepperDidIncrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: 1)
    }

    func stepperDidDecrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: -1)
    }

    func stepperDidReachZero() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: -1)
        delegate?.productDidReachZero(product)
    }

    private func setImage() {
        if let imageUrl = URL(string: product?.imageURL ?? "") {
            productImageView.kf.setImage(with: imageUrl)
        }
    }

    private func setAttribute() {
        if product?.attribute != nil {
            attributeLabel.text = product?.attribute
        } else {
            attributeLabel.text = product?.shortDescription
        }
    }

    private func setCount(count: Int) {
        if count > 0 {
            stepper.counterLabel.text = "\(count)"
            stepper.updateMinusButton()
        } else {
            stepperDidReachZero()
        }
    }

    func updateCounter() {
        guard let product = product, let delegate = delegate else { return }
        let count = delegate.getProductCounter(for: product)
        setCount(count: count)
    }

    func configure(with product: Product) {
        self.product = product
        priceLabel.text = product.priceText
        productNameLabel.text = product.name
        setAttribute()
        setImage()
        updateCounter()
    }
}
