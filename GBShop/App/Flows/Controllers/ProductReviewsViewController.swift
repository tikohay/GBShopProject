//
//  ProductReviewsViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 08.10.2021.
//

import UIKit

class ProductReviewsViewController: UIViewController {
    let allReviews = [AllReviewsResult(idReview: 1, idProduct: 1, text: "hdsladdfa fasfasdf fasfa afsdf jf", user: User(id: 1, login: "hj", name: "Иван", lastname: "Иван")),
                      AllReviewsResult(idReview: 1, idProduct: 1, text: "hdsladdfda dddddssaffewfaffewafwefefgrgrggrgrggwqgwggqgggqggqwgfasfasdf fasfa afsdf jf", user: User(id: 1, login: "hj", name: "jfaldafk", lastname: "jlajfasfaf")),
                      AllReviewsResult(idReview: 1, idProduct: 1, text: "hdsladdfa fasfasdf fasfa afsdf jf", user: User(id: 1, login: "hj", name: "jfaldafk", lastname: "jlajfasfaf")),
                      AllReviewsResult(idReview: 1, idProduct: 1, text: "hdsladdfa fasfasdf fasfa afsdf jf", user: User(id: 1, login: "hj", name: "jfaldafk", lastname: "jlajfasfaf"))]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.whiteColor
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let productReviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.whiteColor
        tableView.separatorStyle = .none
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.reuseId)
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let hideTableViewButton = UIButton()
    private var stackView = UIStackView()
    
    private var isTableViewShown: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargetsToButton()
    }
}

//MARK: - Setup views
extension ProductReviewsViewController {
    private func setupViews() {
        view.backgroundColor = .white
        scrollView.addSubview(hideTableViewButton)
        
        setupScrollView()
        setupCategoryImage()
        setupLabels()
        setupHideTableViewButton()
        setupProductReviewsTableView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCategoryImage() {
        categoryImage.image = UIImage(named: "clothes")
        
        scrollView.addSubview(categoryImage)
        
        NSLayoutConstraint.activate([
            categoryImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupLabels() {
        nameLabel.text = "Гантели"
        priceLabel.text = "1000 рублей"
        
        stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupHideTableViewButton() {
        hideTableViewButton.setTitleColor(Colors.mainBlueColor, for: .normal)
        hideTableViewButton.setTitle("show reviews", for: .normal)
        hideTableViewButton.titleLabel?.textAlignment = .center
        hideTableViewButton.titleLabel?.numberOfLines = 0
        
        hideTableViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hideTableViewButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            hideTableViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupProductReviewsTableView() {
        scrollView.addSubview(productReviewsTableView)
        
        productReviewsTableView.dataSource = self
        productReviewsTableView.delegate = self
        
        NSLayoutConstraint.activate([
            productReviewsTableView.topAnchor.constraint(equalTo: hideTableViewButton.bottomAnchor, constant: 20),
            productReviewsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productReviewsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productReviewsTableView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            productReviewsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

extension ProductReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseId, for: indexPath)
        
        guard let reviewCell = cell as? ReviewTableViewCell else { return cell }
        
        let review = allReviews[indexPath.row]
        reviewCell.configCell(with: review)
        return reviewCell
    }
}

extension ProductReviewsViewController: UITableViewDelegate {
    
}

// MARK: - Setup targets

extension ProductReviewsViewController {
    private func addTargetsToButton() {
        hideTableViewButton.addTarget(self, action: #selector(hideTableViewButtonTapped), for: .touchUpInside)
    }
    
    @objc private func hideTableViewButtonTapped(_ sender: UIButton) {
        if !isTableViewShown {
            sender.setTitle("hide reviews", for: .normal)
            productReviewsTableView.alpha = 1
            productReviewsTableView.isHidden = false
            scrollView.contentInset = .zero
            
        } else {
            sender.setTitle("show reviews", for: .normal)
            UIView.animate(withDuration: 1) {
                self.productReviewsTableView.alpha = 0
                self.scrollView.contentInset.bottom = -self.productReviewsTableView.frame.height
            } completion: { _ in
                self.productReviewsTableView.isHidden = true
            }

        }
        isTableViewShown.toggle()
    }
}
