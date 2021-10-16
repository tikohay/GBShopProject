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
    
    var delegate: ProductListCellDelegate?
    var isProductListController: Bool = true
    
    var _isEditing = false {
        didSet {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseIn) {
                self.deleteButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.deleteButton.isHidden = !self._isEditing
                self.deleteButton.transform = .identity
            }
        }
    }
    
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
    
    var itemCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 20)
        label.text = "1 piece"
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buyButton = ExtendedButton(title: "buy",
                                           backgroundColor: #colorLiteral(red: 1, green: 0.6439002156, blue: 0.1084051505, alpha: 1),
                                           titleColor: Colors.whiteColor)
    private let addToBasketButton = ExtendedButton(title: "add to basket",
                                                   backgroundColor: Colors.mainBlueColor,
                                                   titleColor: Colors.whiteColor)
    private let stepper = UIStepper()
    
    func configCell(with product: CatalogProductResult) {
        self.product = product
        
        setupView()
    }
    
    private func setupView() {
        setupBasketImageView()
        setupNameLabel()
        setupPriceLabel()
        
        if isProductListController {
            setupPaymentForm()
            setupDeleteButton()
        } else {
            setupAddToBasketButton()
        }
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
            nameLabel.leadingAnchor.constraint(equalTo: basketImageView.trailingAnchor, constant: 10)
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
        
        buyButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 20)
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        
        let countItemStackView = UIStackView(arrangedSubviews: [itemCountLabel, stepper])
        countItemStackView.axis = .vertical
        countItemStackView.spacing = 2
        
        self.contentView.addSubview(countItemStackView)
        self.contentView.addSubview(buyButton)
        countItemStackView.translatesAutoresizingMaskIntoConstraints = false
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countItemStackView.topAnchor.constraint(equalTo: basketImageView.bottomAnchor, constant: 30),
            countItemStackView.leadingAnchor.constraint(equalTo: basketImageView.leadingAnchor),
            
            buyButton.topAnchor.constraint(equalTo: countItemStackView.bottomAnchor, constant: 30),
            buyButton.leadingAnchor.constraint(equalTo: countItemStackView.leadingAnchor),
            buyButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupDeleteButton() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        self.contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            deleteButton.widthAnchor.constraint(equalToConstant: 50),
            deleteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            nameLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10)
        ])
    }
    
    private func setupAddToBasketButton() {
        self.contentView.addSubview(addToBasketButton)
        
        addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addToBasketButton.topAnchor.constraint(equalTo: basketImageView.bottomAnchor, constant: 20),
            addToBasketButton.leadingAnchor.constraint(equalTo: basketImageView.leadingAnchor),
            addToBasketButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -100),
            self.contentView.bottomAnchor.constraint(equalTo: addToBasketButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func stepperTapped() {
        var pieceText = "piece"
        if stepper.value == 1 {
            pieceText = "piece"
        } else {
            pieceText = "pieces"
        }
        itemCountLabel.text = String(Int(stepper.value)) + " " + pieceText
    }
    
    @objc func buyButtonTapped() {
        self.delegate?.buy(cell: self)
    }
    
    @objc func deleteButtonTapped() {
        UIView.animate(withDuration: 0.1) {
            self.deleteButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { (_) in
            UIView.animate(withDuration: 0.2) {
                self.deleteButton.transform = .identity
                self.delegate?.delete(cell: self)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
