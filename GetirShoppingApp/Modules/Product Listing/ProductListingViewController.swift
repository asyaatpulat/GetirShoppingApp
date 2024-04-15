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
}

class ProductListingViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var products: [Product] = []
    private var suggestedProducts: [Product] = []
    var presenter: ProductListingPresenterProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        configureNavigationItem()
        setupCollectionView()
        presenter?.fetchProducts()
        presenter?.fetchSuggestedProducts()
    }
    
    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: "ProductListCell")
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureNavigationItem() {
        navigationItem.title = "Ürünler"
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(153)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(185)), subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 0)
                section.interGroupSpacing = 16
                section.contentInsets.trailing = 16
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            } else {
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
}

extension ProductListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return suggestedProducts.count
        } else {
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        let product = indexPath.section == 0 ? suggestedProducts[indexPath.item] : products[indexPath.item]
        cell.configure(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = indexPath.section == 0 ? suggestedProducts[indexPath.item] : products[indexPath.item];
        let productDetailVC = ProductDetailViewController()
        productDetailVC.configureProductDetails(with: product)
        let nav = UINavigationController(rootViewController: productDetailVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}
 
#Preview {
    let collectionView = ProductListingViewController()
    return collectionView
}

