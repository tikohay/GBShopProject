//
//  UIButton + Extensions.swift
//  GBShop
//
//  Created by Karahanyan Levon on 24.09.2021.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                     backgroundColor: UIColor,
                     titleColor: UIColor,
                     font: UIFont? = UIFont(name: "Avenir", size: 20),
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 4) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowOpacity = 0.2
        }
    }
}
