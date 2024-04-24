//
//  ViewController.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 9.04.2024.
//

import UIKit

protocol ProductListingViewControllerProtocol: AnyObject {
    func reloadProducts(_ products: [Product])
    func reloadSuggestedProducts(_ suggestedProducts: [Product])
    func fetchProductsFailed(error: Error)
    func updateTotalPriceLabel(_ totalPrice: Double)
}

class ProductListingViewController: UIViewController {

    private var products: [Product] = []
    private var suggestedProducts: [Product] = []
    var presenter: ProductListingPresenterProtocol?

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var customCartButton: CustomCartButton = {
        let button = CustomCartButton()
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customCartButtonTapped)))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        setupCollectionView()
        presenter?.fetchAllProducts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: Section.suggestedProducts.reuseIdentifier)
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: Section.products.reuseIdentifier)
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc private func customCartButtonTapped() {
        presenter?.didTapCart()
    }

    private func configureNavigationItem() {
        navigationItem.title = "Ürünler"
        if let font = UIFont(name: "OpenSans-Bold", size: 14) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: font
            ]
        }
        let barButtonItem = UIBarButtonItem(customView: customCartButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {(sectionNumber, _) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionNumber) else { return nil }
            switch section {
            case .suggestedProducts:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(153)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(185)), subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 0)
                section.interGroupSpacing = 16
                section.contentInsets.trailing = 16
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .products:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(164.67)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 16
                section.interGroupSpacing = 16
                return section
            }
        }
    }
}

extension ProductListingViewController: ProductListingViewControllerProtocol {
    func reloadProducts(_ products: [Product]) {
        self.products = products
        self.collectionView.reloadData()
    }

    func reloadSuggestedProducts(_ suggestedProducts: [Product]) {
        self.suggestedProducts = suggestedProducts
        self.collectionView.reloadData()
    }

    func fetchProductsFailed(error: Error) {
        print("data fetch failed.")
    }

    func updateTotalPriceLabel(_ totalPrice: Double) {
        customCartButton.updateTotalPriceLabel(totalPrice)
        customCartButton.isHidden = totalPrice == 0
    }
}

extension ProductListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .suggestedProducts:
            return suggestedProducts.count
        case .products:
            return products.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        let reuseIdentifier = section.reuseIdentifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProductListCell else {
            return UICollectionViewCell()
        }
        let product = getProduct(for: indexPath)
        cell.delegate = self
        cell.configure(with: product)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = getProduct(for: indexPath)
        presenter?.didSelectProduct(product)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    private func getProduct(for indexPath: IndexPath) -> Product {
        let product = indexPath.section == Section.suggestedProducts.rawValue ? suggestedProducts[indexPath.item] : products[indexPath.item]
        return product
    }
}

extension ProductListingViewController: ProductListCellDelegate {
    func addButtonTapped(for product: Product) {
        presenter?.addProductToBasket(product)
    }

    func updateProductCounter(for product: Product, counter: Int) {
        presenter?.updateProductCounter(product, counter: counter)
    }

    func getProductCounter(for product: Product) -> Int {
        return presenter?.getProductCounter(product) ?? 0
    }
}
