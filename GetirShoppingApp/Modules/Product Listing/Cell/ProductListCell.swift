//
//  HorizontalListCell.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 10.04.2024.
//

import UIKit
import SnapKit

class ProductListCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductListCell"
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.spacing = 8
        return stackView
    }()
    
    private let productImageView = ProductImageView()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "textPrimary")
        label.text = "test"
        return label
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "textDark")
        label.text = "Product Name"
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "textSecondary")
        label.text = "Attribute"
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
        addSubview(productImageView)
        addSubview(priceLabel)
        addSubview(productNameLabel)
        addSubview(attributeLabel)

        containerView.backgroundColor = .black
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(8)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
        }
        
        attributeLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(2)
        }
        
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(containerView)
            make.height.equalTo(productImageView.snp.width)
        }
    }

    func configure(with product: Product) {
        priceLabel.text = product.price
        productNameLabel.text = product.name
        attributeLabel.text = product.attribute
      }
}

struct Product {
  let name: String
  let price: String
  let attribute: String
  let imageURL: String?
}

#Preview {
    let cell = ProductListCell()
    return cell
}
