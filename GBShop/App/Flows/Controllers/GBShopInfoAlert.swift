//
//  CustomAlertViewController2.swift
//  GBShop
//
//  Created by Karahanyan Levon on 27.09.2021.
//

import UIKit

class GBShopInfoAlert: UIViewController {
    var blurView = UIVisualEffectView()
    let alertView = UIView()
    let titleLabel = UILabel()
    let textLabel = UILabel()
    let okButton = UIButton(title: "Ok",
                            backgroundColor: Colors.mainBlueColor,
                            titleColor: Colors.whiteColor)
    
    var titleText: String?
    var descriptionText: String?
    
    convenience init(title: String, text: String) {
        self.init()
        self.titleText = title
        self.descriptionText = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargetToButtons()
    }
}

//MARK: - Setup views
extension GBShopInfoAlert {
    private func setupViews() {
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
        
        alertView.backgroundColor = Colors.whiteColor
        alertView.layer.cornerRadius = 30
        alertView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabels() {
        alertView.addSubview(textLabel)
        alertView.addSubview(titleLabel)
        
        titleLabel.font = UIFont(name: "Helvetica", size: 25)
        titleLabel.text = titleText
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        textLabel.font = UIFont(name: "Avenir Book", size: 20)
        textLabel.text = descriptionText
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupOkButton() {
        alertView.addSubview(okButton)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            
            textLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            textLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            okButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            okButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20)
        ])
    }
}

//MARK: - Setup targets
extension GBShopInfoAlert {
    private func addTargetToButtons() {
        okButton.addTarget(self,
                           action: #selector(dismissController),
                           for: .touchUpInside)
    }
    
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
