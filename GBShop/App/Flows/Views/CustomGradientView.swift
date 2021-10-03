//
//  CustomGradientView.swift
//  GBShop
//
//  Created by Karahanyan Levon on 03.10.2021.
//

import UIKit

class CustomGradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateGradientView()
    }
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    var startColor: UIColor = #colorLiteral(red: 0, green: 0.01568627451, blue: 0.1568627451, alpha: 1)
    var endColor: UIColor = #colorLiteral(red: 0, green: 0.3058823529, blue: 0.5725490196, alpha: 1)
    var startLocation: CGFloat = 0
    var secondLocation: CGFloat = 0.8
    var endLocation: CGFloat = 1
    var startPoint: CGPoint = .zero
    var endPoint: CGPoint = .init(x: 1, y: 1)
    
    private func updateGradientView() {
        self.gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        self.gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
