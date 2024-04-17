//
//  ProductBasketViewController.swift
//  GetirShoppingApp
//
//  Created by Asya Atpulat on 16.04.2024.
//

import UIKit

class ProductBasketViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var products: [Product] = []
    private var suggestedProducts: [Product] = []
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBasketButton()
        setupCollectionView()
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
        return button
    }()
    
    private func setupCustomBasketButton() {
        view.addSubview(customBasketButton)
        customBasketButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.height.equalTo(50)
        }
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
                section.contentInsets = .init(top: 12, leading: 16, bottom: 20, trailing: 16)
                section.interGroupSpacing = 24
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(153)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(92), heightDimension: .absolute(185)), subitems: [item])
                group.interItemSpacing = .fixed(16)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(16))), elementKind: ProductBasketViewController.categoryHeaderId, alignment: .topLeading)
                ]
                section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 0)
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
                cell.configure(with: product)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
                let product = suggestedProducts[indexPath.item]
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

/*
#Preview {
   let collectionView = ProductBasketViewController()
   return collectionView
}


*/
