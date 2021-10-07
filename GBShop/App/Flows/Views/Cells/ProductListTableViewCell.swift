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
    
    func configCell(with product: CatalogProductResult) {
        self.product = product
        
        setupView()
    }
    
    private func setupView() {
        setupBasketImageView()
        setupNameLabel()
        setupPriceLabel()
    }
    
    private func setupBasketImageView() {
        self.addSubview(basketImageView)
        
        NSLayoutConstraint.activate([
            basketImageView.heightAnchor.constraint(equalToConstant: 50),
            basketImageView.widthAnchor.constraint(equalToConstant: 50),
            basketImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            basketImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.text = product?.name
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: basketImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: basketImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupPriceLabel() {
        var price: String = "-"
        
        if let value = product?.price {
            price = String(value)
        }
        
        priceLabel.text = ("\(price) рублей")
        
        self.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
