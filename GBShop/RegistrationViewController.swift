//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 25.09.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = UIFont(name: "Geeza Pro Bold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var creditCardLabel: UILabel = {
        let label = UILabel()
        label.text = "Credit card"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var genderSegmentedControl = UISegmentedControl(first: "Male",
                                                            second: "Female",
                                                            third: "Another")
    
    private var button = UIButton(title: "Registration",
                                  backgroundColor: #colorLiteral(red: 0.2082675993, green: 0.3012821078, blue: 0.5670520067, alpha: 1),
                                  titleColor: .white)
    
    private var usernameTextField = OneLineTextField()
    private var emailTextField = OneLineTextField()
    private var passwordTextField = OneLineTextField(isTextSecured: true)
    private var creditCardTextField = OneLineTextField()
    private var bioTextField = OneLineTextField()
    
    private var isKeyboardShown = false
    var isRegistration = false
    var logoText: String {
        isRegistration ? "Registration" : "Setup"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
    }
}

//MARK: - Setup views
extension RegistrationViewController {
    private func setupViews() {
        setupScrollView()
        setupStackView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        let usernameStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        usernameStackView.axis = .vertical
        usernameStackView.distribution = .fill
        usernameStackView.spacing = 10
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailStackView.axis = .vertical
        emailStackView.distribution = .fill
        emailStackView.spacing = 10
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordStackView.axis = .vertical
        passwordStackView.distribution = .fill
        passwordStackView.spacing = 10
        
        let creditCardStackView = UIStackView(arrangedSubviews: [creditCardLabel, creditCardTextField])
        creditCardStackView.axis = .vertical
        creditCardStackView.distribution = .fill
        creditCardStackView.spacing = 10
        
        let bioStackView = UIStackView(arrangedSubviews: [bioLabel, bioTextField])
        bioStackView.axis = .vertical
        bioStackView.distribution = .fill
        bioStackView.spacing = 10
        
        let genderStackView = UIStackView(arrangedSubviews: [genderLabel, genderSegmentedControl])
        genderStackView.axis = .vertical
        genderStackView.distribution = .fill
        genderStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [usernameStackView,
                                                       emailStackView,
                                                       passwordStackView,
                                                       creditCardStackView,
                                                       bioStackView,
                                                       genderStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(logoLabel)
        scrollView.addSubview(stackView)
        scrollView.addSubview(button)
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            logoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoLabel.topAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - Setup observers and gestures recognizer
extension RegistrationViewController {
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHiden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    private func addTapGestureRecognizer() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    @objc private func keyboardWillBeShown(notification: Notification) {
        guard !isKeyboardShown else { return }
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize?.height ?? 0.0, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        isKeyboardShown = true
    }
    
    @objc private func keyboardWillBeHiden() {
        guard isKeyboardShown else { return }
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        isKeyboardShown = false
    }
    
    @objc private func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
//id: 123,
//username: "Somebody",
//password: "mypassword",
//email: "some@some.ru",
//gender: Gender.man.rawValue,
//creditCard: "9872389-2424-234224-234",
//bio: "This is good! I think I will switch to another language")
