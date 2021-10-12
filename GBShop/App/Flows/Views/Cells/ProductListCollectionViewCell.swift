//
//  CustomProductLitstCollectionViewCell.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell, ConfigCell {
    typealias T = String
    
    static var reuseId: String = "CustomProductLitstCollectionViewCell"
    
    private var category: String?
    
    let containerView: CustomGradientView = {
        let view = CustomGradientView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configCell(with category: String) {
        self.category = category
        
        setupViews()
//        addAnimationToCell()
    }
    
    private func setupViews() {
        setupCell()
        setupContainerView()
        setupCategoryLabel()
    }
    
    private func setupCell() {
        self.layer.shadowOffset = .init(width: 3, height: 3)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3
        
        self.layer.cornerRadius = 10
    }
    
    private func setupContainerView() {
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupCategoryLabel() {
        categoryLabel.text = category
        
        containerView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func addAnimationToCell() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func cellTapped() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { (_) in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
