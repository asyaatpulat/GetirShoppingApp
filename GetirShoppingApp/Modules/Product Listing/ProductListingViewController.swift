//
//  ViewController.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 9.04.2024.
//

import UIKit

class ProductListingViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        configureNavigationItem()
        setupCollectionView()
    }
    
    let mockProducts: [Product] = [
        Product(name: "T-Shirt", price: "$29.99", attribute: "Cotton", imageURL: "https://example.com/image1.jpg"),
        Product(name: "Sweatshirt", price: "$49.99", attribute: "Fleece", imageURL: "https://example.com/image2.jpg"),
        Product(name: "Joggers", price: "$34.99", attribute: "Cotton Blend", imageURL: "https://example.com/image3.jpg"),
        Product(name: "Hat", price: "$19.99", attribute: "Wool", imageURL: "https://example.com/image4.jpg"),
        Product(name: "Sunglasses", price: "$89.99", attribute: "UV Protection", imageURL: "https://example.com/image5.jpg"),
        Product(name: "Backpack", price: "$69.99", attribute: "Water Resistant", imageURL: "https://example.com/image6.jpg"),
        Product(name: "Water Bottle", price: "$14.99", attribute: "Stainless Steel", imageURL: "https://example.com/image7.jpg"),
        Product(name: "T-Shirt", price: "$29.99", attribute: "Cotton", imageURL: "https://example.com/image1.jpg"),
        Product(name: "Sweatshirt", price: "$49.99", attribute: "Fleece", imageURL: "https://example.com/image2.jpg"),
        Product(name: "Joggers", price: "$34.99", attribute: "Cotton Blend", imageURL: "https://example.com/image3.jpg"),
        Product(name: "Hat", price: "$19.99", attribute: "Wool", imageURL: "https://example.com/image4.jpg"),
        Product(name: "Sunglasses", price: "$89.99", attribute: "UV Protection", imageURL: "https://example.com/image5.jpg"),
        Product(name: "Backpack", price: "$69.99", attribute: "Water Resistant", imageURL: "https://example.com/image6.jpg"),
        Product(name: "Water Bottle", price: "$14.99", attribute: "Stainless Steel", imageURL: "https://example.com/image7.jpg"),
        Product(name: "Sunglasses", price: "$89.99", attribute: "UV Protection", imageURL: "https://example.com/image5.jpg"),
        Product(name: "Backpack", price: "$69.99", attribute: "Water Resistant", imageURL: "https://example.com/image6.jpg"),
        Product(name: "Water Bottle", price: "$14.99", attribute: "Stainless Steel", imageURL: "https://example.com/image7.jpg"),
        Product(name: "T-Shirt", price: "$29.99", attribute: "Cotton", imageURL: "https://example.com/image1.jpg"),
        Product(name: "Sweatshirt", price: "$49.99", attribute: "Fleece", imageURL: "https://example.com/image2.jpg"),
        Product(name: "Joggers", price: "$34.99", attribute: "Cotton Blend", imageURL: "https://example.com/image3.jpg"),
        Product(name: "Hat", price: "$19.99", attribute: "Wool", imageURL: "https://example.com/image4.jpg"),
        Product(name: "Sunglasses", price: "$89.99", attribute: "UV Protection", imageURL: "https://example.com/image5.jpg"),
        Product(name: "Backpack", price: "$69.99", attribute: "Water Resistant", imageURL: "https://example.com/image6.jpg"),
        Product(name: "Water Bottle", price: "$14.99", attribute: "Stainless Steel", imageURL: "https://example.com/image7.jpg"),
    ]
    
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
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/4), heightDimension: .absolute(153)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(185)), subitems: [item])
                group.interItemSpacing = .fixed(16)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(164.67)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: [item])
                // group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                //section.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
                return section
            }
        }
    }
}

extension ProductListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else {
            return 13
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        let product = mockProducts[indexPath.item]
        cell.configure(with: product)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}

#Preview {
    let collectionView = ProductListingViewController()
    return collectionView
}

