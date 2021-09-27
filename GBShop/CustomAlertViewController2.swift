//
//  CustomAlertViewController2.swift
//  GBShop
//
//  Created by Karahanyan Levon on 27.09.2021.
//

import UIKit

class CustomAlertViewController2: UIViewController {
    var blurView = UIVisualEffectView()
    let alertView = UIView()
    let topLabel = UILabel()
    let descriptionLabel = UILabel()
    let okButton = UIButton(title: "Ok",
                            backgroundColor: Colors.mainBlueColor,
                            titleColor: .white)
    
    var topLabelText: String?
    var descriptionText: String?
    
    convenience init(topLabelText: String, descriptionText: String) {
        self.init()
        self.topLabelText = topLabelText
        self.descriptionText = descriptionText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBlurView()
        setupAlertView()
        setupLabels()
        setupOkButton()
        setupConstraints()
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurView = UIVisualEffectView(effect: blur)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(blurView)
    }
    
    private func setupAlertView() {
        blurView.contentView.addSubview(alertView)
    
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 30
        alertView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabels() {
        alertView.addSubview(descriptionLabel)
        alertView.addSubview(topLabel)
        
        topLabel.font = UIFont(name: "Helvetica", size: 25)
        topLabel.text = topLabelText
        topLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont(name: "Avenir Book", size: 20)
        descriptionLabel.text = descriptionText
        descriptionLabel.numberOfLines = 0
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupOkButton() {
        alertView.addSubview(okButton)
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.addTarget(self,
                           action: #selector(dismissController),
                           for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            alertView.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            alertView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 150),
            alertView.heightAnchor.constraint(equalToConstant: 250),
            alertView.widthAnchor.constraint(equalToConstant: 240),
            
            topLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            topLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            
            okButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            okButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
