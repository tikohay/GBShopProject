//
//  CustomProductLitstCollectionViewCell.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import UIKit

class CustomProductLitstCollectionViewCell: UICollectionViewCell, ConfigCell {
    static var reuseId: String = "CustomProductLitstCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Samsung"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func configeCell(with product: String) {
        setupViews()
    }
    
    private func setupViews() {
        setupCell()
        setupNameLabel()
    }
    
    private func setupCell() {
        self.backgroundColor = .white
        
        self.layer.shadowOffset = .init(width: 3, height: 3)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3
        
        self.layer.cornerRadius = 10
    }
    
    private func setupNameLabel() {
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
