//
//  UserInformationViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 25.09.2021.
//

import UIKit

class UserInformationViewController: UIViewController {
    var username: String?
    var email: String?
    var creditCard: String?
    var bio: String?
    var gender: String?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.whiteColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal information"
        label.font = UIFont(name: "Geeza Pro Bold", size: 30)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 30)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private var bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private var creditCardLabel: UILabel = {
        let label = UILabel()
        label.text = "Credit card -"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private var creditCardDetailsLabel: BlurredLabel = {
        let label = BlurredLabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private var blurButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextToLabel()
        setupBlurButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
    }
    
    private func addTextToLabel() {
        usernameLabel.text = "\(username ?? "Nikolas Sarkozi")"
        emailLabel.text = "Email - \(email ?? "sarkozi@bk.ru")"
        bioLabel.text = "Bio - \(bio ?? "my name's Sarkozi. i love your application, it's really usefullmy name's Sarkozi. i love your application, it's really usefullmy name's Sarkozi. i love your application, it's really usefullmy name's Sarkozi. i love your application, it's really usefull")"
        genderLabel.text = "Gender -\(gender ?? "male")"
        creditCardDetailsLabel.text = "\(creditCard ?? "123-12-12-12345")"
    }
}

//MARK: - Setup views
extension UserInformationViewController {
    private func setupViews() {
        setupScrollView()
        setupStackView()
        setupNavigationView()
    }
    
    private func setupNavigationView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(leftButtonItemTapped))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(rightButtonItemTapped))
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        let creditCardStackView = UIStackView(arrangedSubviews: [creditCardLabel,
                                                                 creditCardDetailsLabel,
                                                                 blurButton])
        creditCardStackView.axis = .horizontal
        creditCardStackView.spacing = 2
        creditCardStackView.distribution = .fill
        creditCardStackView.isBaselineRelativeArrangement = true
        
        let stackView = UIStackView(arrangedSubviews: [emailLabel,
                                                       bioLabel,
                                                       genderLabel,
                                                       creditCardStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(logoLabel)
        scrollView.addSubview(usernameLabel)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            usernameLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 50),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupBlurButton() {
        blurButton.addTarget(self,
                             action: #selector(blurCreditCard),
                             for: .touchUpInside)
    }
    
    @objc func blurCreditCard(_ sender: UIButton) {
        creditCardDetailsLabel.isBlurring.toggle()
        if creditCardDetailsLabel.isBlurring {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @objc func leftButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func rightButtonItemTapped() {
        let toVC = RegistrationViewController()
        toVC.isRegistration = false
        toVC.onCompletion = {
            print("setup")
        }
        toVC.modalPresentationStyle = .automatic
        toVC.modalTransitionStyle = .coverVertical
        present(toVC, animated: true, completion: nil)
    }
}
