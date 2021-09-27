//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 25.09.2021.
//

import UIKit

class ProfileEditorViewController: UIViewController {
    // поменять все на let (проверить во всем проекте)
    var isRegistration = false {
        didSet {
            titleLabel.text = titleText
            submitButton.setTitle(titleText, for: .normal)
            submitButton.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        }
    }
    var titleText: String {
        isRegistration ? "Registration" : "Setup"
    }
    var onCompletion: (() -> Void)?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.whiteColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro Bold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont(name: "Helvetica", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var genderSegmentedControl = UISegmentedControl(first: "Male",
                                                            second: "Female",
                                                            third: "Another")
    
    private var submitButton = UIButton(title: nil,
                                                   backgroundColor: Colors.mainBlueColor,
                                                   titleColor: .white)
    private var closeButton = UIButton()
    
    private var usernameTextField = GBShopStandardTextField(labelText: "Name")
    private var emailTextField = GBShopStandardTextField(labelText: "Email")
    private var passwordTextField = GBShopStandardTextField(labelText: "Passowrd", isSecured: true)
    private var creditCardTextField = GBShopStandardTextField(labelText: "Credit card")
    private var bioTextField = GBShopStandardTextField(labelText: "Bio")
    
    private var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureRecognizer()
        setupViews()
        buttonTapped() // переименовать
        
        // сделать все так как в логине, в том числе нйминги
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}

//MARK: - Setup views
extension ProfileEditorViewController {
    private func setupViews() {
        setupScrollView()
        setupStackView()
        setupDoneButton()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        let genderStackView = UIStackView(arrangedSubviews: [genderLabel, genderSegmentedControl])
        genderStackView.axis = .vertical
        genderStackView.distribution = .fill
        genderStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField,
                                                       emailTextField,
                                                       passwordTextField,
                                                       creditCardTextField,
                                                       bioTextField,
                                                       genderStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(stackView)
        scrollView.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            submitButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func buttonTapped() {
        submitButton.addTarget(self, action: #selector(onCompletionUsed), for: .touchUpInside)
    }
    
    private func setupDoneButton() {
        if isRegistration {
            closeButton.isHidden = true
        } else {
            closeButton.isHidden = false
        }
        
        closeButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        closeButton.tintColor = Colors.mainBlueColor
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        closeButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    @objc func onCompletionUsed() {
        onCompletion?()
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Setup observers and gestures recognizer
extension ProfileEditorViewController {
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
