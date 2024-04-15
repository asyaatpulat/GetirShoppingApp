//
//  HorizontalListCell.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 10.04.2024.
//

import UIKit
import SnapKit
import Kingfisher

class ProductListCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductListCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
   /* private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()*/
    
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
        containerView.addSubview(priceLabel)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(attributeLabel)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
            //make.bottom.equalTo(containerView)
        }
        
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(containerView)
            make.height.equalTo(productImageView.snp.width)
        }
    }

    func configure(with product: Product) {
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
      }
}

#Preview {
    let cell = ProductListCell()
    return cell
}
