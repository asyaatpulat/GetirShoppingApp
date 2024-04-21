//
//  ProductBasketViewController.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 16.04.2024.
//

import UIKit

protocol ProductBasketViewControllerProtocol: AnyObject {
    func reloadSuggestedProducts(_ suggestedProducts: [Product])
    func fetchProductsFailed(error: Error)
    func reloadProducts(_ products: [Product])
    func updateTotalPriceLabel(_ totalPrice: Double)
    func reloadNewProducts(_ products: [Product])
}

class ProductBasketViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var products: [Product] = []
    private var suggestedProducts: [Product] = []
    var presenter: ProductBasketPresenterProtocol?
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBasketButton()
        setupCollectionView()
        presenter?.fetchSuggestedProducts()
        presenter?.loadBasketData()
        configureNavigationItem()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Sepetim"
        if let font = UIFont(name: "OpenSans-Bold", size: 14) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: font,
            ]
        }
        if let closeImage = UIImage(named: "closeIcon") {
            let barButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTapped))
            navigationItem.leftBarButtonItem = barButtonItem
        }
        
        if let trashImage = UIImage(named: "trashWhiteIcon") {
            let barButtonItem = UIBarButtonItem(image: trashImage, style: .plain, target: self, action: #selector(trashButtonTapped))
            navigationItem.rightBarButtonItem = barButtonItem
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .bgPrimary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.bgLight]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func trashButtonTapped() {
        presenter?.clearBasket()
        self.products.removeAll()
        self.suggestedProducts.removeAll()
        dismiss(animated: true)
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductBasketCell.self, forCellWithReuseIdentifier: "ProductBasketCell")
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: "ProductListCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(customBasketButton.snp.top).offset(-12)
        }
        collectionView.register(Header.self, forSupplementaryViewOfKind: ProductBasketViewController.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
    private lazy var customBasketButton: CustomBasketButton = {
        let button = CustomBasketButton()
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 10
        button.layer.shadowColor = UIColor.basketButtonShadow.cgColor
        return button
    }()
    
    private func setupCustomBasketButton() {
        view.addSubview(customBasketButton)
        customBasketButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.height.equalTo(50)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(customBasketButtonTapped))
        customBasketButton.addGestureRecognizer(gesture)
        view.backgroundColor = .bgLight
    }
    
    @objc private func customBasketButtonTapped() {
        let totalPrice = presenter?.fetchedTotalPrice() ?? 0.0
        let price = "₺\(String(format: "%.2f", totalPrice))"
        let successMessage = "Toplam alışveriş tutarınız \(price)!"
        
        showAlert(with: "İşlem Başarılı", message: successMessage) {
            self.dismiss(animated: true, completion: nil)
        }
        presenter?.clearBasket()
        self.products.removeAll()
        self.suggestedProducts.removeAll()
    }
    
  
    private func showAlert(with title: String, message: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                // group.interItemSpacing = .fixed(12)
                let section = NSCollectionLayoutSection(group: group)
                //  section.contentInsets.leading = 16
                //section.contentInsets.trailing = 16
                //section.contentInsets.top = 16
                section.contentInsets = .init(top: 12, leading: 16, bottom: 32, trailing: 16)
                section.interGroupSpacing = 24
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(153)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(185)), subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(16))), elementKind: ProductBasketViewController.categoryHeaderId, alignment: .topLeading)
                ]
                section.contentInsets = .init(top: 12, leading: 16, bottom: 0, trailing: 0)
                section.interGroupSpacing = 16
                section.contentInsets.trailing = 16
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
    }
}

extension ProductBasketViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return products.count
        } else {
            return suggestedProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBasketCell", for: indexPath) as! ProductBasketCell
            let product = products[indexPath.item]
            cell.delegate = self
            cell.configure(with: product)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
            let product = suggestedProducts[indexPath.item]
            cell.delegate = self
            cell.configure(with: product)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
}

class Header: UICollectionReusableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Önerilen Ürünler"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductBasketViewController: ProductBasketViewControllerProtocol {
    func reloadNewProducts(_ products: [Product]) {
           self.products = products
           collectionView.reloadData()
       }
    
    
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
        customBasketButton.updateTotalPriceLabel(totalPrice)
    }
    
    func updatedCell(_ products: [Product]) {
        self.products = products
        self.collectionView.reloadData()
    }
}

extension ProductBasketViewController: ProductListCellDelegate, ProductBasketCellDelegate {
    func productDidReachZero(_ product: Product) {
        if let index = products.firstIndex(where: { $0 == product }) {
            products.remove(at: index)
            collectionView.reloadData()
        }
    }
    
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
/*
 #Preview {
 let collectionView = ProductBasketViewController()
 return collectionView
 }
 
 
 */
