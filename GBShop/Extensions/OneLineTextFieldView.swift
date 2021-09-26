//
//  OneLineTextFieldView.swift
//  GBShop
//
//  Created by Karahanyan Levon on 26.09.2021.
//

import UIKit

class OneLineTextFieldView: UIView {
    var textfield = UITextField()
    var bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(isSecured: Bool) {
        self.init()

        textfield.isSecureTextEntry = isSecured
        setupView()
    }
    
    func setupView() {
        self.addSubview(textfield)
        self.addSubview(bottomView)
        
        bottomView.backgroundColor = #colorLiteral(red: 0.7810183167, green: 0.7763768435, blue: 0.7845870852, alpha: 1)
        textfield.borderStyle = .none
        
        self.translatesAutoresizingMaskIntoConstraints = false
        textfield.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: self.topAnchor),
            textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textfield.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            bottomView.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 2),
            bottomView.leadingAnchor.constraint(equalTo: textfield.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: textfield.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
