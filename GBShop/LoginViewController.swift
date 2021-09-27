//
//  ViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 26.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    let requestFactory = RequestFactory()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.whiteColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "GBShop"
        label.textColor = .black
        label.font = UIFont(name: "Geeza Pro Bold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton = UIButton(title: "Log in",
                                       backgroundColor: Colors.whiteColor,
                                       titleColor: .black,
                                       isShadow: true)
    private let registrationButton = UIButton(title: "Sign up",
                                              backgroundColor: Colors.mainBlueColor,
                                              titleColor: Colors.whiteColor,
                                              isShadow: false)
    
    private let loginStandardTextField = GBShopStandardTextField(labelText: "Login")
    private let passwordStandardTextField = GBShopStandardTextField(labelText: "Password",
                                                                    isSecured: true)
    
    private var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureRecognizer()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - Setup views
extension LoginViewController {
    private func setupViews() {
        setupScrollView()
        setupTextFieldsAndLabels()
        setupButtons()
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
    
    private func setupTextFieldsAndLabels() {
        let loginFormStackView = UIStackView(arrangedSubviews: [loginStandardTextField,
                                                                passwordStandardTextField])
        loginFormStackView.axis = .vertical
        loginFormStackView.spacing = 10
        loginFormStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStackView = UIStackView(arrangedSubviews: [loginButton, registrationButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 20
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(logoLabel)
        scrollView.addSubview(loginFormStackView)
        scrollView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            
            loginFormStackView.topAnchor.constraint(equalTo: logoLabel.topAnchor, constant: 100),
            loginFormStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginFormStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            buttonStackView.topAnchor.constraint(equalTo: loginFormStackView.bottomAnchor, constant: 50),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupButtons() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        guard let login = loginStandardTextField.textfield.text,
              let password = passwordStandardTextField.textfield.text
        else { return }
        
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: login, password: password) { response in
            switch response.result {
            case .success(_):
                //вынести в отдельную функцию
                DispatchQueue.main.async {
//                    let toVC = MainTabBarController()
//                    toVC.modalTransitionStyle = .flipHorizontal
//                    toVC.modalPresentationStyle = .fullScreen
//                    self.present(toVC, animated: true, completion: nil)
                    let toVC = CustomAlertViewController2(title: "Warning",
                                                          text: "login or password is wrong")
                    toVC.modalPresentationStyle = .overCurrentContext
                    toVC.modalTransitionStyle = .crossDissolve
                    self.present(toVC, animated: true, completion: nil)
                }
            case .failure(_):
                //вынести в отдельную функцию
                DispatchQueue.main.async {
                    let toVC = CustomAlertViewController2(title: "Warning",
                                                          text: "login or password is wrong")
                    toVC.modalPresentationStyle = .overCurrentContext
                    toVC.modalTransitionStyle = .crossDissolve
                    self.present(toVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func registrationButtonTapped() {
        let toVC = RegistrationViewController()
        toVC.isRegistration = true
        toVC.onCompletion = {
            print("registration")
        }
        navigationController?.pushViewController(toVC, animated: true)
    }
}

// MARK: - Setup observers and gestures recognizer
extension LoginViewController {
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
