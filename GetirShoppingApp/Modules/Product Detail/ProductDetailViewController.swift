//
//  ProductDetailViewController.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 11.04.2024.
//

import UIKit
import SnapKit

protocol ProductDetailViewControllerProtocol: AnyObject {
    func displayProductDetails(with product: Product)
}

class ProductDetailViewController: UIViewController, CustomStepperDelegate {
    
    var presenter: ProductDetailPresenterProtocol?
    let customButton = CustomCartButton()
    
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
        let stepper = CustomStepper(orientation: .horizontal)
        stepper.isHidden = true
        return stepper
    }()
    
    private var isStepperShown: Bool = false {
        didSet {
            button.isHidden = isStepperShown
            stepper.isHidden = !isStepperShown
        }
    }
    
    func stepperDidReachZero() {
        isStepperShown = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stepper.delegate = self
        configureNavigationItem()
        setupViews()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Ürün Detayı"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        let barButtonItem = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = barButtonItem
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .bgPrimary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.bgLight]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(attributeLabel)
        view.addSubview(bottomView)
        bottomView.addSubview(button)
        stepper.stackOrientation = .horizontal
        
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
}

extension ProductDetailViewController: ProductDetailViewControllerProtocol {
    func displayProductDetails(with product: Product) {
        self.priceLabel.text = product.priceText
        self.productNameLabel.text = product.name
        if product.attribute != nil {
            self.attributeLabel.text = product.attribute
        } else {
            self.attributeLabel.text = product.shortDescription
        }
        if let imageUrl = URL(string: product.imageURL ?? "") {
            self.productImageView.kf.setImage(with: imageUrl)
        }
    }
}
/*
#Preview {
    let view = ProductDetailViewController()
    return view
}*/
