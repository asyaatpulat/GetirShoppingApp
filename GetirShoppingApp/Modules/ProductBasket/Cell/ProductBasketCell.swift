//
//  ProductBasketCell.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 16.04.2024.
//

import UIKit
import SnapKit

protocol ProductBasketCellDelegate: AnyObject {
   // func addButtonTapped(for product: Product)
    func updateProductCounter(for product: Product, counter: Int)
    func getProductCounter(for product: Product) -> Int
    func productDidReachZero(_ product: Product)
}

class ProductBasketCell: UICollectionViewCell, CustomStepperDelegate {
    func stepperDidIncrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: 1)
    }
    
    func stepperDidDecrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: -1)
    }
    
    static let reuseIdentifier = "ProductBasketCell"
    weak var delegate: ProductBasketCellDelegate?
    var product: Product?

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var productImageView = ProductImageView()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
        label.textColor = UIColor(named: "textDark")
        label.text = "Product Name"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
        label.textColor = UIColor(named: "textSecondary")
        label.text = "Attribute"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.textColor = UIColor(named: "textPrimary")
        label.text = "test"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var stepper: CustomStepper = {
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
            //productImageView.backgroundColor = .cyan
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
    
    func stepperDidReachZero() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(for: product, counter: -1)
        delegate?.productDidReachZero(product)
    }
    
    func configure(with product: Product) {
        self.product = product
        priceLabel.text = product.priceText
        productNameLabel.text = product.name
        if product.attribute != nil {
            attributeLabel.text = product.attribute
        } else {
            attributeLabel.text = product.shortDescription
        }
        if let imageUrl = URL(string: product.imageURL ?? "") {
            productImageView.kf.setImage(with: imageUrl)
        }
        
        guard let delegate = delegate else { return }
        let count = delegate.getProductCounter(for: product)
        if count > 0 {
            stepper.counterLabel.text = "\(count)"
            stepper.updateMinusButton()
        } else {
            stepperDidReachZero()
        }
    }
}
