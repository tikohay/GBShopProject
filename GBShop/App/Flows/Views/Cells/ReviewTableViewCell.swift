//
//  ReviewTableViewCell.swift
//  GBShop
//
//  Created by Karahanyan Levon on 08.10.2021.
//

import UIKit

class ReviewTableViewCell: UITableViewCell, ConfigCell {
    typealias T = AllReviewsResult
    
    static var reuseId: String = "ReviewTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Al Nile Bold", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let reviewTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Al Nile", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9025625587, green: 0.9108906388, blue: 0.9317789674, alpha: 1)
        view.layer.borderColor = Colors.mainBlueColor.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configCell(with review: AllReviewsResult) {
        let name = "\(review.user.name) \(review.user.lastname)"
        let text = review.text
        reviewForm(with: name, text: text)
    }
    
    private func reviewForm(with name: String, text: String) {
        nameLabel.text = name
        reviewTextLabel.text = text
        
        self.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(reviewTextLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            
            reviewTextLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            reviewTextLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            reviewTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2),
            containerView.bottomAnchor.constraint(equalTo: reviewTextLabel.bottomAnchor),
            
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20)
        ])
    }
}
