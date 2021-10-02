//
//  ProductListViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import UIKit

class ProductListViewController: UIViewController {
    private var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomProductLitstCollectionViewCell.self,
                                forCellWithReuseIdentifier: CustomProductLitstCollectionViewCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
}

//MARK: - Setup views
extension ProductListViewController {
    private func setupViews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(productCollectionView)
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            productCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomProductLitstCollectionViewCell.reuseId,
                                                      for: indexPath) as! CustomProductLitstCollectionViewCell
        cell.configeCell(with: "")
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
