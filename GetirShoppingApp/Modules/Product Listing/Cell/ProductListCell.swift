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
    func addProductToBasket(_ product: Product)
    func updateProductCounter(_ product: Product, counter: Int)
}

class ProductListCell: UICollectionViewCell, CustomStepperDelegate {
    
    static let reuseIdentifier = "ProductListCell"
    weak var delegate: ProductListCellDelegate?
    var product: Product?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var productImageView = ProductImageView()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "textPrimary")
        label.text = "test"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "textDark")
        label.text = "Product Name"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "textSecondary")
        label.text = "Attribute"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.productCardShadow.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1
        button.backgroundColor = UIColor.bgLight
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
        addButton.isHidden = true
        stepper.isHidden = false
        guard let product = self.product else { return }
        delegate?.addProductToBasket(product)
        stepper.counterLabel.text = "1"
        stepper.updateMinusButton()
    }
    
    func stepperDidReachZero() {
        addButton.isHidden = false
        stepper.isHidden = true
    }
    
    func stepperDidIncrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(product, counter: 1)
    }
    
    func stepperDidDecrease() {
        guard let product = self.product else { return }
        delegate?.updateProductCounter(product, counter: -1)
    }
    
    var basketManager = BasketManager()
    
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
        basketManager.loadBasketFromUserDefaults()
        
        if let count = basketManager.getBasket()[product] {
            stepper.counterLabel.text = "\(count)"
            stepper.isHidden = false
            addButton.isHidden = true
            stepper.updateMinusButton()
        } else {
            stepper.isHidden = true
            addButton.isHidden = false
        }
    }
}

#Preview {
    let cell = ProductListCell()
    return cell
}
