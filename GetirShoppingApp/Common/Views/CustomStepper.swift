//
//  CustomStepper.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 14.04.2024.
//
import UIKit
import SnapKit

class CustomStepper : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 1
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.productCardShadow.cgColor
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    } ()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle(" - ", for: .normal)
        button.backgroundColor = .white
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.setTitleColor(UIColor(named: "bgPrimary"), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = UIColor.bgLight
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle(" + ", for: .normal)
        button.setTitleColor(UIColor(named: "bgPrimary"), for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        button.clipsToBounds = true
        button.backgroundColor = UIColor.bgLight
        return button
    }()
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .textLight
        label.backgroundColor = .bgPrimary
        label.text = "2"
        return label
    }()
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(counterLabel)
        stackView.addArrangedSubview(plusButton)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        counterLabel.snp.makeConstraints { make in
            make.width.equalTo(plusButton)
        }
        
        minusButton.snp.makeConstraints { make in
            make.width.equalTo(plusButton)
        }
        
    }
    
    func updateMinusButton() {
        if let counterText = counterLabel.text, let counter = Int(counterText) {
            if counter == 1 {
                minusButton.setImage(UIImage(named: "trashIcon"), for: .normal)
                minusButton.setTitle(nil, for: .normal)
            } else {
                minusButton.setTitle("-", for: .normal)
                minusButton.setImage(nil, for: .normal)
            }
        }
    }
}


#Preview {
    let a = CustomStepper()
    return a
}

