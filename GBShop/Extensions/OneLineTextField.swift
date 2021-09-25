//
//  OneLineTextField.swift
//  GBShop
//
//  Created by Karahanyan Levon on 24.09.2021.
//

import UIKit

class OneLineTextField: UITextField {
    init(isTextSecured: Bool? = false) {
        super.init(frame: .zero)
        self.borderStyle = .none
        self.autocorrectionType = .no
        self.isSecureTextEntry = isTextSecured ?? false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomView = UIView()
        bottomView.backgroundColor = #colorLiteral(red: 0.7810183167, green: 0.7763768435, blue: 0.7845870852, alpha: 1)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        self.keyboardType = .emailAddress
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0,
                                             left: 10,
                                             bottom: 0,
                                             right: 0))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0,
                                             left: 10,
                                             bottom: 0,
                                             right: 0))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0,
                                             left: 10,
                                             bottom: 0,
                                             right: 20))
    }
}


