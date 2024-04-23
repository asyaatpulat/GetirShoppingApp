//
//  CustomStepper.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 14.04.2024.
//
import UIKit
import SnapKit

protocol CustomStepperDelegate: AnyObject {
    func stepperDidReachZero()
    func stepperDidIncrease()
    func stepperDidDecrease()
}

class CustomStepper: UIView {

    private enum Constants {
        static let shadowOpacity: Float = 1
        static let offset = CGSize(width: 0, height: 0)
        static let shadowRadius: CGFloat = 6
        static let cornerRadius: CGFloat = 8

        enum Color {
            static let textColorPrimary = UIColor.textPrimary
            static let shadowColor = UIColor.productCardShadow.cgColor
            static let buttonColor = UIColor.bgLight
        }
    }

    weak var delegate: CustomStepperDelegate?
    var stackOrientation: StackOrientation?

    init(orientation: StackOrientation) {
        self.stackOrientation = orientation
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.backgroundColor = .white
        view.layer.shadowOffset = Constants.offset
        view.layer.shadowRadius = Constants.shadowRadius
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.shadowColor = Constants.Color.shadowColor
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        switch stackOrientation {
        case .horizontal:
            stackView.axis = .horizontal
            stackView.addArrangedSubview(minusButton)
            stackView.addArrangedSubview(counterLabel)
            stackView.addArrangedSubview(plusButton)
        case .vertical:
            stackView.axis = .vertical
            stackView.addArrangedSubview(plusButton)
            stackView.addArrangedSubview(counterLabel)
            stackView.addArrangedSubview(minusButton)
        default:
            break
        }
        return stackView
    }()

    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.minus, for: .normal)
        button.setTitle(nil, for: .normal)
        button.backgroundColor = .white
        if stackOrientation == .horizontal {
            button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else {
            button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        button.setTitleColor(UIColor.bgPrimary, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.backgroundColor = Constants.Color.buttonColor
        return button
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.plus, for: .normal)
        button.setTitle(nil, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        if stackOrientation == .horizontal {
            button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        button.clipsToBounds = true
        button.backgroundColor = Constants.Color.buttonColor
        return button
    }()

    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .textLight
        label.backgroundColor = .bgPrimary
        label.text = "1"
        return label
    }()

    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(stackView)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }

        counterLabel.snp.makeConstraints { make in
            make.width.equalTo(plusButton)
            make.height.equalTo(plusButton)
        }

        minusButton.snp.makeConstraints { make in
            make.width.equalTo(plusButton)
            make.height.equalTo(plusButton)
        }

        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)

    }

    @objc private func minusButtonTapped() {
        if let currentCounter = Int(counterLabel.text ?? "0"), currentCounter > 0 {
            counterLabel.text = "\(currentCounter - 1)"
        }
        if let counterText = counterLabel.text, let counter = Int(counterText), counter == 0 {
            delegate?.stepperDidReachZero()
        }
        updateMinusButton()
        delegate?.stepperDidDecrease()
    }

    @objc private func plusButtonTapped() {
        if let currentCounter = Int(counterLabel.text ?? "0") {
            counterLabel.text = "\(currentCounter + 1)"
        }
        updateMinusButton()
        delegate?.stepperDidIncrease()
    }

    func updateMinusButton() {
        if let counterText = counterLabel.text, let counter = Int(counterText) {
            if counter == 1 {
                minusButton.setImage(UIImage.trash, for: .normal)
                minusButton.setTitle(nil, for: .normal)
            } else {
                minusButton.setImage(UIImage.minus, for: .normal)
                minusButton.setTitle(nil, for: .normal)
            }
        }
    }
}
