//
//  ProductDetailViewController.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 11.04.2024.
//

import UIKit
import SnapKit

class ProductDetailViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 1
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor(named: "productCardShadow")?.cgColor
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "textPrimary")
        return label
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "textDark")
        label.textAlignment = .center
        return label
    }()
    
    private let attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "textSecondary")
        label.textAlignment = .center
        return label
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 8
        view.layer.shadowColor = UIColor(named: "bottomShadow")?.cgColor
        return view
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap Me", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "bgPrimary")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Ürün Detayı"        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(attributeLabel)
        view.addSubview(bottomView)
        bottomView.addSubview(button)
        
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(319)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        attributeLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(bottomView.snp.top).offset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureProductDetails(with product: Product) {
        priceLabel.text = product.price
        productNameLabel.text = product.name
        attributeLabel.text = product.attribute
    }
}

#Preview {
    let view = ProductDetailViewController()
    return view
}
