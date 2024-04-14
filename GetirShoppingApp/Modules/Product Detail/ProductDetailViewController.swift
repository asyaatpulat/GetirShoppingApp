//
//  ProductDetailViewController.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 11.04.2024.
//

import UIKit
import SnapKit

class ProductDetailViewController: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 1
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor(named: "productCardShadow")?.cgColor
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "textPrimary")
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "textDark")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(named: "textSecondary")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 8
        view.layer.shadowColor = UIColor(named: "bottomShadow")?.cgColor
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "bgPrimary")
        button.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.isHidden = true
        return stepper
    }()
    
    private var isStepperShown: Bool = false {
        didSet {
            button.isHidden = isStepperShown
            stepper.isHidden = !isStepperShown
        }
    }
    
    @objc private func addToCartButtonTapped() {
        isStepperShown = true
        stepper.isHidden = false
        stepper.counterLabel.text = "1"
        view.addSubview(stepper)
        stepper.snp.makeConstraints{ make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(bottomView.snp.top).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(146)
            make.height.equalTo(48)
        }
        stepper.updateMinusButton()
    }
    
    @objc private func minusButtonTapped() {
        if let currentCounter = Int(stepper.counterLabel.text ?? "0"), currentCounter > 0 {
            stepper.counterLabel.text = "\(currentCounter - 1)"
        }
        if let counterText = stepper.counterLabel.text, let counter = Int(counterText), counter == 0 {
            isStepperShown = false
        }
        stepper.updateMinusButton()
    }
    
    @objc private func plusButtonTapped() {
        if let currentCounter = Int(stepper.counterLabel.text ?? "0"), currentCounter > 0 {
            stepper.counterLabel.text = "\(currentCounter + 1)"
            stepper.updateMinusButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Ürün Detayı"
        stepper.minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        stepper.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        //navigationController?.navigationBar.barTintColor = UIColor.bgPrimary
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.bgPrimary
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
        priceLabel.text = product.priceText
        productNameLabel.text = product.name
        attributeLabel.text = product.attribute
    }
}

#Preview {
    let view = ProductDetailViewController()
    return view
}
