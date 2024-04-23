//
//  HorizontalListCell.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 10.04.2024.
//

import UIKit
import SnapKit
import Kingfisher

protocol ProductListCellDelegate: AnyObject {
    func addButtonTapped(for product: Product)
    func updateProductCounter(for product: Product, counter: Int)
    func getProductCounter(for product: Product) -> Int
}

class ProductListCell: UICollectionViewCell, CustomStepperDelegate {

    private enum Constants {
        static let shadowOpacity: Float = 1
        static let offset = CGSize(width: 0, height: 1)
        static let shadowRadius: CGFloat = 3
        static let cornerRadius: CGFloat = 8
        static let numberOfLines: Int = 1
        static let numberOfLinesProduct: Int = 2

        enum Font {
            static let priceLabel = UIFont.openSansBold(ofSize: 14)
            static let productNamelabel = UIFont.openSansSemiBold(ofSize: 12)
            static let attributeLabel = UIFont.openSansSemiBold(ofSize: 12)
        }

        enum Color {
            static let textColorPrimary = UIColor.textPrimary
            static let textColorDark = UIColor.textDark
            static let textColorSecondary = UIColor.textSecondary
            static let shadowColor = UIColor.productCardShadow.cgColor
            static let buttonColor = UIColor.bgLight
        }
    }

    static let reuseIdentifier = "ProductListCell"
    private var product: Product?
    weak var delegate: ProductListCellDelegate?

    private lazy var containerView = UIView()
    private lazy var productImageView = ProductImageView()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.priceLabel
        label.textColor = Constants.Color.textColorPrimary
        label.numberOfLines = Constants.numberOfLinesProduct
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

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

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowColor = Constants.Color.shadowColor
        button.layer.shadowOffset = Constants.offset
        button.layer.shadowRadius = Constants.shadowRadius
        button.layer.shadowOpacity = Constants.shadowOpacity
        button.backgroundColor = Constants.Color.buttonColor
        return button
    }()

    private lazy var stepper: CustomStepper = {
        let stepper = CustomStepper(orientation: .vertical)
        stepper.isHidden = true
        stepper.delegate = self
        return stepper
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        stepper.delegate = self
        addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(attributeLabel)
        addSubview(addButton)
        addSubview(stepper)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        addButton.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(addButton.snp.width)
            make.top.equalToSuperview().offset(-8)
            make.right.equalToSuperview().inset(-8)
        }

        stepper.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(96)
            make.top.equalToSuperview().offset(-8)
            make.right.equalToSuperview().inset(-8)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(containerView)
        }

        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.trailing.equalTo(containerView)
        }

        attributeLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(containerView)
        }

        productImageView.snp.makeConstraints { make in
            make.width.equalTo(containerView)
            make.height.equalTo(productImageView.snp.width)
        }
    }

    @objc private func addButtonTapped() {
        guard let product = self.product else { return }
        addButton.isHidden = true
        stepper.isHidden = false
        delegate?.addButtonTapped(for: product)
        stepper.counterLabel.text = "1"
        stepper.updateMinusButton()
    }

    func stepperDidReachZero() {
        addButton.isHidden = false
        stepper.isHidden = true
    }

    func stepperDidIncrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: 1)
    }

    func stepperDidDecrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: -1)
    }

    private func setCount(count: Int) {
        if count > 0 {
            stepper.counterLabel.text = "\(count)"
            stepper.isHidden = false
            addButton.isHidden = true
            stepper.updateMinusButton()
        } else {
            stepper.isHidden = true
            addButton.isHidden = false
        }
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

    private func updateCounter() {
        guard let product = product, let delegate = delegate else { return }
        let count = delegate.getProductCounter(for: product)
        setCount(count: count)
    }

    func configure(with product: Product) {
        self.product = product
        priceLabel.text = product.priceText
        productNameLabel.text = product.name
        setImage()
        setAttribute()
        updateCounter()
    }
}
