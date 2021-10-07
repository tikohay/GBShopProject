//
//  ProductListViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import UIKit

class ProductListViewController: UIViewController {
    let requestFactory = RequestFactory()
    
    private var productCategories = ProductCategory.productCategories
    private var products: [CatalogProductResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
    }
    
    private let allProductsLabel: UILabel = {
        let label = UILabel()
        label.text = "All products"
        label.font = UIFont(name: "Geeza Pro Bold", size: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myBasketLabel: UILabel = {
        let label = UILabel()
        label.text = "My basket"
        label.font = UIFont(name: "Geeza Pro Bold", size: 30)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductListCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductListCollectionViewCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let productTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductListTableViewCell.self,
                           forCellReuseIdentifier: ProductListTableViewCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getCatalog()
    }
    
    private func getCatalog() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        
        catalog.getCatalog(pageNumber: 1, categoryId: 1, category: "") { response in
            switch response.result {
            case .success(let result):
                self.products = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Setup views
extension ProductListViewController {
    private func setupViews() {
        view.backgroundColor = .white
        setupAllProductsLabel()
        setupProductCollectionView()
        setupMyBasketLabel()
        setupProductTableView()
    }
    
    private func setupAllProductsLabel() {
        view.addSubview(allProductsLabel)
        
        NSLayoutConstraint.activate([
            allProductsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            allProductsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupProductCollectionView() {
        view.addSubview(productCollectionView)
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            productCollectionView.topAnchor.constraint(equalTo: allProductsLabel.bottomAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupMyBasketLabel() {
        view.addSubview(myBasketLabel)
        
        NSLayoutConstraint.activate([
            myBasketLabel.topAnchor.constraint(equalTo: productCollectionView.bottomAnchor, constant: 20),
            myBasketLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupProductTableView() {
        view.addSubview(productTableView)
        
        productTableView.dataSource = self
        productTableView.delegate = self
        
        NSLayoutConstraint.activate([
            productTableView.topAnchor.constraint(equalTo: myBasketLabel.bottomAnchor),
            productTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.reuseId,
                                                      for: indexPath)
        guard let productCategoryCell = cell as? ProductListCollectionViewCell else { return cell }
        
        let category = productCategories[indexPath.row]
        productCategoryCell.configCell(with: category)
        return productCategoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ProductListCollectionViewCell {
                cell.containerView.transform = .init(scaleX: 0.9, y: 0.9)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ProductListCollectionViewCell {
                cell.containerView.transform = .identity
            }
        }
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

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseId,
                                                 for: indexPath)
        guard let productCell = cell as? ProductListTableViewCell else { return cell }

        let product = products[indexPath.row]
        productCell.configCell(with: product)
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProductListViewController: UITableViewDelegate {
    
}
