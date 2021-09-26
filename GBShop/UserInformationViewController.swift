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
        scrollView.backgroundColor = .white
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
    
    private var creditCardLabel: UILabel = {
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
    
//    init(userName: String,
//         email: String,
//         creditCard: String,
//         bio: String,
//         gender: String) {
//        self.username = userName
//        self.email = userName
//        self.creditCard = userName
//        self.bio = userName
//        self.gender = userName
//
//        usernameLabel.text = "Name - \(userName)"
//        emailLabel.text = "Email - \(email)"
//        creditCardLabel.text = "Credit card - \(creditCard)"
//        bioLabel.text = "Bio - \(bio)"
//        genderLabel.text = "Gender -\(gender)"
//        super.init(nibName: nil, bundle: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextToLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
    }
    
    private func addTextToLabel() {
        usernameLabel.text = "\(username ?? "Nikolas Sarkozi")"
        emailLabel.text = "Email - \(email ?? "sarkozi@bk.ru")"
        creditCardLabel.text = "Credit card - \(creditCard ?? "123-12-12-12345")"
        bioLabel.text = "Bio - \(bio ?? "bio - my name's Sarkozi. i love your application, it's really usefullmy name's Sarkozi. i love your application, it's really usefullmy name's Sarkozi. i love your application, it's really usefullmy name's Sarkozi. i love your application, it's really usefull")"
        genderLabel.text = "Gender -\(gender ?? "male")"
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
        let stackView = UIStackView(arrangedSubviews: [emailLabel,
                                                       creditCardLabel,
                                                       bioLabel,
                                                       genderLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
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
}
