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
    func updateTotalPriceLabel(_ price: Double)
    func updateItemCounter(_ count: Int)
}

protocol ProductDetailDelegate: AnyObject {
    func didUpdateProduct(_ product: Product)
}

class ProductDetailViewController: UIViewController, CustomStepperDelegate {

    private enum Constants {
        static let shadowOpacity: Float = 1
        static let offset = CGSize(width: 0, height: 1)
        static let shadowRadius: CGFloat = 3
        static let bottomOffset = CGSize(width: 0, height: -4)
        static let bottomShadowRadius: CGFloat = 8
        static let cornerRadius: CGFloat = 10

        enum Font {
            static let priceLabel = UIFont.openSansBold(ofSize: 20)
            static let productNamelabel = UIFont.openSansSemiBold(ofSize: 16)
            static let attributeLabel = UIFont.openSansSemiBold(ofSize: 12)
            static let buttonLabel = UIFont.openSansBold(ofSize: 14)
        }

        enum Color {
            static let textColorPrimary = UIColor.textPrimary
            static let textColorDark = UIColor.textDark
            static let textColorSecondary = UIColor.textSecondary
            static let shadowColor = UIColor.productCardShadow.cgColor
            static let bottomShadow = UIColor.bottomShadow.cgColor
            static let buttonColor = UIColor.bgPrimary
        }
    }

    var presenter: ProductDetailPresenterProtocol?
    weak var delegate: ProductDetailDelegate?

    private lazy var customButton: CustomCartButton = {
        let button = CustomCartButton()
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customCartButtonTapped)))
        return button
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.backgroundColor = .white
        view.layer.shadowOffset = Constants.offset
        view.layer.shadowRadius = Constants.shadowRadius
        view.layer.shadowColor = Constants.Color.shadowColor
        return view
    }()

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.priceLabel
        label.textAlignment = .center
        label.textColor = Constants.Color.textColorPrimary
        return label
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.productNamelabel
        label.textColor = Constants.Color.textColorDark
        label.textAlignment = .center
        return label
    }()

    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.attributeLabel
        label.textColor = Constants.Color.textColorSecondary
        label.textAlignment = .center
        return label
    }()

    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.shadowOffset = Constants.bottomOffset
        view.layer.shadowRadius = Constants.bottomShadowRadius
        view.layer.shadowColor = Constants.Color.bottomShadow
        return view
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.titleLabel?.font = Constants.Font.buttonLabel
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.backgroundColor = Constants.Color.buttonColor
        button.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var stepper: CustomStepper = {
        let stepper = CustomStepper(orientation: .horizontal)
        stepper.isHidden = true
        return stepper
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stepper.delegate = self
        configureNavigationItem()
        setupViews()
        fetchTotalPrice()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTotalPrice()
        presenter?.updateItemCounter()
    }

    @objc private func customCartButtonTapped() {
        presenter?.didTapCart()
    }

    func stepperDidIncrease() {
        presenter?.increaseProductCounter()
    }

    func stepperDidDecrease() {
        presenter?.decreaseProductCounter()
    }

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
        stepper.counterLabel.text = "1"
        presenter?.increaseProductCounter()
        stepper.updateMinusButton()
    }

    private func getItemCounter() {
        presenter?.updateItemCounter()
    }

    private func fetchTotalPrice() {
        presenter?.fetchTotalPrice()
    }

    private func configureNavigationItem() {
        navigationItem.title = "Ürün Detayı"
        if let font = UIFont(name: "OpenSans-Bold", size: 14) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: font
            ]
        }

        if let closeImage = UIImage(named: "closeIcon") {
            let barButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTapped))
            navigationItem.leftBarButtonItem = barButtonItem
        }
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
        view.addSubview(stepper)
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

        stepper.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(bottomView.snp.top).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(146)
            make.height.equalTo(48)
        }
    }
}

extension ProductDetailViewController: ProductDetailViewControllerProtocol {
    func displayProductDetails(with product: Product) {
        self.priceLabel.text = product.priceText
        self.productNameLabel.text = product.name
        self.attributeLabel.text = product.attribute ?? product.shortDescription
        setImage(with: product)
        updateItemCounter(presenter?.getProductCounter(product) ?? 0)
        delegate?.didUpdateProduct(product)
    }

    func setImage(with product: Product) {
        if let imageUrl = URL(string: product.imageURL ?? "") {
            self.productImageView.kf.setImage(with: imageUrl)
        }
    }

    func updateTotalPriceLabel(_ price: Double) {
        customButton.updateTotalPriceLabel(price)
        customButton.isHidden = price == 0
    }

    func updateItemCounter(_ count: Int) {
        if count > 0 {
            isStepperShown = true
            stepper.updateMinusButton()
            stepper.counterLabel.text = "\(count)"
        } else {
            isStepperShown = false
        }
    }
}
