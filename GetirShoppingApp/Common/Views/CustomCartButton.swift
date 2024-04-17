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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        //view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor.bgLight
        view.layer.borderColor = UIColor.bgLight.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cartIcon")
        imageView.contentMode = .center
       // imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "₺32,50"
       // label.layer.cornerRadius = 8
        //label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textPrimary
        label.textAlignment = .center
        label.backgroundColor = UIColor.bgPrimarySubtle
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
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        // Handle button tap event
    }
    
    func updateTotalPriceLabel(_ totalPrice: Double) {
        textLabel.text = "₺\(String(format: "%.2f", totalPrice))"
    }
}


#Preview {
    let cell = CustomCartButton()
    return cell
}
