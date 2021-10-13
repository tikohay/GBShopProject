//
//  CategoryProductListViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 07.10.2021.
//

import UIKit

class CategoryProductListViewController: UIViewController {
    private let requestFactory = RequestFactory()
    var category: String = ""
    
    private var products: [CatalogProductResult] = [] {
        didSet {
            reloadTableViewData()
        }
    }
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mainBlueColor
        label.font = UIFont(name: "Geeza Pro Bold", size: 50)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var productTableView: UITableView = {
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
        
        catalog.getCatalog(pageNumber: 1, categoryId: 1, category: category) { response in
            switch response.result {
            case .success(let result):
                self.products = result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.productTableView.reloadData()
        }
    }
}

//MARK: - Setup views
extension CategoryProductListViewController {
    private func setupViews() {
        view.backgroundColor = .white
        
        setupCategoryLabel()
        setupProductTableView()
    }
    
    private func setupCategoryLabel() {
        categoryLabel.text = category
        
        view.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupProductTableView() {
        view.addSubview(productTableView)
        
        productTableView.dataSource = self
        productTableView.delegate = self
        
        NSLayoutConstraint.activate([
            productTableView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            productTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CategoryProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseId, for: indexPath)
        guard let productCell = cell as? ProductListTableViewCell else { return cell }
        let product = products[indexPath.row]
        productCell.configCell(with: product)
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let product = products[indexPath.row]
        let toVC = ProductReviewsViewController()
        toVC.product = product
        toVC.categoryImageName = category.lowercased()
        navigationController?.pushViewController(toVC, animated: true)
    }
}

extension CategoryProductListViewController: UITableViewDelegate {
    
}


