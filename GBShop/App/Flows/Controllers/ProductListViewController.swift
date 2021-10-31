//
//  ProductListViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import UIKit
import FirebaseCrashlytics
import Firebase

class ProductListViewController: UIViewController {
    let requestFactory = RequestFactory()
    
    private var productCategories = ProductCategory.productCategories
    private var products: [CatalogProductResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
            if products.count == 0 {
                isEditing = false
                editButton.tintColor = Colors.mainBlueColor
            }
        }
    }
    
    private let allProductsLabel: UILabel = {
        let label = UILabel()
        label.text = "All products"
        label.textColor = Colors.mainBlueColor
        label.font = UIFont(name: "Geeza Pro Bold", size: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myBasketLabel: UILabel = {
        let label = UILabel()
        label.text = "My basket"
        label.textColor = Colors.mainBlueColor
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
    
    private var editButton = UIBarButtonItem()
    
    enum ProductError: Error {
        case payError
        case deleteProductError
    }

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
        setupNavigationBar()
        setupAllProductsLabel()
        setupProductCollectionView()
        setupMyBasketLabel()
        setupProductTableView()
    }
    
    private func setupNavigationBar() {
        editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                     target: self,
                                     action: #selector(editButtonTapped))
        self.navigationItem.rightBarButtonItem = editButton
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
    
    @objc func editButtonTapped() {
        isEditing.toggle()

        if isEditing {
            self.editButton.tintColor = .red

        } else {
            editButton.tintColor = Colors.mainBlueColor
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if let indexPath = productTableView.indexPathsForVisibleRows {
            for indexPath in indexPath {
                if let cell = productTableView.cellForRow(at: indexPath) as? ProductListTableViewCell {
                    cell._isEditing = editing
                }
            }
        }
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productCategories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.reuseId,
                                                      for: indexPath)
        guard let productCategoryCell = cell as? ProductListCollectionViewCell else { return cell }
        
        let category = productCategories[indexPath.row]
        productCategoryCell.configCell(with: category)
        return productCategoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let toVC = CategoryProductListViewController()
        
        let category = productCategories[indexPath.row]
        toVC.category = category
        toVC.onAddToBasketTaped = { product in
            self.products.insert(product, at: 0)
        }
        navigationController?.pushViewController(toVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didHighlightItemAt indexPath: IndexPath) {
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
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseId,
                                                 for: indexPath)
        guard let productCell = cell as? ProductListTableViewCell else { return cell }

        let product = products[indexPath.row]
        productCell.isProductListController = true
        productCell.configCell(with: product)
        productCell.productListDelegate = self
        productCell._isEditing = isEditing
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProductListViewController: UITableViewDelegate {
    
}

extension ProductListViewController: ProductListCellDelegate {
    func buy(cell: ProductListTableViewCell) {
        if let indexPath = productTableView.indexPath(for: cell) {
            let payBasket = requestFactory.makePayBasketRequestFactory()
            payBasket.payBasket(userId: 1) { response in
                switch response.result {
                case .success(let result):
                    let parametres = ["result": result]
                    Analytics.logEvent("user pay success",
                                       parameters: parametres)
                    DispatchQueue.main.async {
                        let product = self.products[indexPath.row]
                        let piece = cell.itemCountLabel.text ?? ""
                        let toVC = GBShopInfoAlert(title: "Congratulation",
                                                   text: "you've just baught \(String(describing: piece)) \(product.name)")
                        toVC.modalPresentationStyle = .overCurrentContext
                        toVC.modalTransitionStyle = .crossDissolve
                        self.present(toVC, animated: true, completion: nil)
                        self.products.remove(at: indexPath.row)
                        self.productTableView.reloadData()
                    }
                case .failure(let error):
                    let product = self.products[indexPath.row]
                    let keysAndValues = [
                        "error": error.localizedDescription,
                        "productname": product.name,
                        "prodcutId": product.id
                    ] as [String : Any]
                    
                    Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
                    Crashlytics.crashlytics().log("pay product in crash")
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func delete(cell: ProductListTableViewCell) {
        if let indexPath = productTableView.indexPath(for: cell) {
            let deleteProductFromBasket = requestFactory.makeDeleteProductFromBasketRequestFactory()
            deleteProductFromBasket.deleteProductFromBasket(productId: 1) { response in
                DispatchQueue.main.async {
                    let product = self.products[indexPath.row]
                    let toVC = GBShopInfoAlert(title: "Are you sure",
                                               text: "you want to remove \(product.name) ?")
                    toVC.isConfirmationAlert = true
                    toVC.modalPresentationStyle = .overCurrentContext
                    toVC.modalTransitionStyle = .crossDissolve
                    self.present(toVC, animated: true, completion: nil)
                    toVC.onConfirmButtonTapped = {
                        switch response.result {
                        case .success(let success):
                            let parametres = ["result": success.result]
                            Analytics.logEvent("user delete success",
                                               parameters: parametres)
                            self.products.remove(at: indexPath.row)
                            self.productTableView.reloadData()
                            print(success)
                        case .failure(let error):
                            let product = self.products[indexPath.row]
                            let keysAndValues = [
                                "error": error.localizedDescription,
                                "productname": product.name,
                                "prodcutId": product.id
                            ] as [String : Any]
                            
                            Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
                            Crashlytics.crashlytics().log("delete product in crash")
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}


