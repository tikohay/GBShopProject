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
    
    var startColor: UIColor = #colorLiteral(red: 0, green: 0.8235294118, blue: 1, alpha: 1)
    var endColor: UIColor = #colorLiteral(red: 0.2274509804, green: 0.4823529412, blue: 0.8352941176, alpha: 1)
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
