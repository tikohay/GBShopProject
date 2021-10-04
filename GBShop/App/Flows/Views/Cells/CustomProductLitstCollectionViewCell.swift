//
//  CustomProductLitstCollectionViewCell.swift
//  GBShop
//
//  Created by Karahanyan Levon on 02.10.2021.
//

import UIKit

class CustomProductLitstCollectionViewCell: UICollectionViewCell, ConfigProductCell {
    static var reuseId: String = "CustomProductLitstCollectionViewCell"
    
    private let containerView: CustomGradientView = {
        let view = CustomGradientView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .white
        label.text = "Sport"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func configeCell(with product: Any) {
        setupViews()
        addAnimationToCell()
    }
    
    private func setupViews() {
        setupCell()
        setupContainerView()
        setupNameLabel()
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
    
    private func setupNameLabel() {
        containerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
