//
//  ViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 26.08.2021.
//

import UIKit
import FirebaseCrashlytics
import Firebase

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
    
    private let loginButton = ExtendedButton(title: "Log in",
                                             backgroundColor: Colors.whiteColor,
                                             titleColor: .black,
                                             isShadow: true,
                                             accessibilityIdentifier: "loginButton")
    private let registrationButton = ExtendedButton(title: "Sign up",
                                                    backgroundColor: Colors.mainBlueColor,
                                                    titleColor: Colors.whiteColor,
                                                    isShadow: false,
                                                    accessibilityIdentifier: "registrationButton")
    
    private let loginStandardTextField = GBShopStandardTextField(labelText: "Login",
                                                                 accessibilityIdentifier: "loginTF")
    private let passwordStandardTextField = GBShopStandardTextField(labelText: "Password",
                                                                    isSecured: true,
                                                                    accessibilityIdentifier: "passwordTF")
    private let activityView = UIActivityIndicatorView()
    
    private var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureRecognizer()
        setupViews()
        addTargetToButtons()
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
        setupAuthForm()
        setupActivityView()
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
    
    private func setupAuthForm() {
        let loginFormStackView = UIStackView(arrangedSubviews: [loginStandardTextField,
                                                                passwordStandardTextField])
        loginFormStackView.axis = .vertical
        loginFormStackView.spacing = 10
        loginFormStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonsStackView = UIStackView(arrangedSubviews: [loginButton, registrationButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 20
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(logoLabel)
        scrollView.addSubview(loginFormStackView)
        scrollView.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            
            loginFormStackView.topAnchor.constraint(equalTo: logoLabel.topAnchor, constant: 100),
            loginFormStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginFormStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            buttonsStackView.topAnchor.constraint(equalTo: loginFormStackView.bottomAnchor, constant: 50),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupActivityView() {
        activityView.center = view.center
        activityView.color = Colors.mainBlueColor
        activityView.style = .large
        view.addSubview(activityView)
    }
    
    private func presentMainTabBar() {
        DispatchQueue.main.async {
            let toVC = MainTabBarController()
            toVC.modalTransitionStyle = .flipHorizontal
            toVC.modalPresentationStyle = .fullScreen
            self.present(toVC, animated: true, completion: nil)
        }
    }
    
    private func presentGBShopInfoAlert() {
        DispatchQueue.main.async {
            let toVC = GBShopInfoAlert(title: "Warning",
                                       text: "Login or password is wrong")
            toVC.modalPresentationStyle = .overCurrentContext
            toVC.modalTransitionStyle = .crossDissolve
            self.present(toVC, animated: true, completion: nil)
        }
    }
}

// MARK: - Setup observers and gestures recognizer
extension LoginViewController {
    private func addTapGestureRecognizer() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
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

// MARK: - Setup targets
extension LoginViewController {
    private func addTargetToButtons() {
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        registrationButton.addTarget(self,
                                     action: #selector(registrationButtonTapped),
                                     for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        guard let login = loginStandardTextField.textfield.text,
              let password = passwordStandardTextField.textfield.text,
              loginStandardTextField.textfield.text != "",
              passwordStandardTextField.textfield.text != ""
        else {
            presentGBShopInfoAlert()
            return
        }
        self.startActivityViewAnimating()
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: login, password: password) { response in
            self.stopActivityAnimating()
            switch response.result {
            case .success(let result):
                let parametres = ["username": result.user.name,
                                  "lastname": result.user.lastname,
                                  "login": result.user.login]
                Analytics.logEvent("log in succes",
                                   parameters: parametres)
                self.presentMainTabBar()
            case .failure(let error):
                Crashlytics.crashlytics().record(error: error)
                self.presentGBShopInfoAlert()
            }
        }
    }
    
    private func startActivityViewAnimating() {
        DispatchQueue.main.async {
            self.activityView.isHidden = false
            self.activityView.startAnimating()
        }
    }
    
    private func stopActivityAnimating() {
        DispatchQueue.main.async {
            self.activityView.isHidden = true
            self.activityView.stopAnimating()
        }
    }
    
    private func pushProfileEditorViewController() {
        let toVC = ProfileEditorViewController()
        toVC.isRegistration = true
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    @objc private func registrationButtonTapped() {
        pushProfileEditorViewController()
    }
}
