//
//  BlurOverLabelView.swift
//  GBShop
//
//  Created by Karahanyan Levon on 27.09.2021.
//

import UIKit

class BlurOverLabelView: UIView {
    private var label = UILabel()
    private var blurView = UIVisualEffectView()
    
//    var isBlurHiden: Bool = false {
//        didSet {
//            blurView.isHidden = isBlurHiden
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupBlurView()
        setupLabel()
        setupConstraints()
    }
    
    convenience init(labelText: String) {
        self.init()
        
        layer.isOpaque = false
        layer.needsDisplayOnBoundsChange = true
        layer.contentsScale = UIScreen.main.scale
        layer.contentsGravity = .center
        isOpaque = false
        isUserInteractionEnabled = false
        contentMode = .redraw
        self.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        setupLabel()
        setupBlurView()
        setupConstraints()
    }
    
    private func setupLabel() {
        self.addSubview(label)
        
        label.font = UIFont(name: "Helvetica", size: 40)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .extraLight)
        blurView = UIVisualEffectView(effect: blur)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.isHidden = false
        self.addSubview(blurView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: blurView.topAnchor),
            label.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: blurView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: blurView.bottomAnchor),
            
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.bottomAnchor.constraint(equalTo: blurView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
