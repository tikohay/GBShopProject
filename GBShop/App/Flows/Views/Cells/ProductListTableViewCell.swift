//
//  CustomTableViewCell.swift
//  GBShop
//
//  Created by Karahanyan Levon on 03.10.2021.
//

import UIKit

class ProductListTableViewCell: UITableViewCell, ConfigCell {
    typealias T = CatalogProductResult
    
    static var reuseId: String = "ProductListTableViewCell"
    
    private var product: CatalogProductResult?
    
    private let basketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "basketImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont(name: "Arial", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var itemCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 20)
        label.text = "1"
        return label
    }()
    
    private let stepper = UIStepper()
    
    func configCell(with product: CatalogProductResult) {
        self.product = product
        
        setupView()
    }
    
    private func setupView() {
        setupBasketImageView()
        setupNameLabel()
        setupPriceLabel()
        setupPaymentForm()
    }
    
    private func setupBasketImageView() {
        self.contentView.addSubview(basketImageView)
        
        NSLayoutConstraint.activate([
            basketImageView.heightAnchor.constraint(equalToConstant: 50),
            basketImageView.widthAnchor.constraint(equalToConstant: 50),
            basketImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            basketImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.text = product?.name
        self.contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: basketImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: basketImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupPriceLabel() {
        var price: String = "-"
        
        if let value = product?.price {
            price = String(value)
        }
        
        priceLabel.text = ("\(price) рублей")
        
        self.contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
    
    private func setupPaymentForm() {
        stepper.addTarget(self, action: #selector(stepperTapped), for: .touchUpInside)
        stepper.minimumValue = 1
        
        let countItemStackView = UIStackView(arrangedSubviews: [itemCountLabel, stepper])
        countItemStackView.axis = .vertical
        countItemStackView.spacing = 5
        
        self.contentView.addSubview(countItemStackView)
        countItemStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countItemStackView.topAnchor.constraint(equalTo: basketImageView.bottomAnchor, constant: 20),
            countItemStackView.leadingAnchor.constraint(equalTo: basketImageView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: countItemStackView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func stepperTapped() {
        itemCountLabel.text = String(Int(stepper.value))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
