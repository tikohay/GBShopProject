//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 25.09.2021.
//

import UIKit
import FirebaseCrashlytics
import Firebase

class ProfileEditorViewController: UIViewController {
    let requestFactory = RequestFactory()
    
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
    
    enum SegmentControlGender: Int {
        case male = 0
        case female = 1
        case another = 2
        
        var description: String {
            switch self {
            case .male:
                return "Male"
            case .female:
                return "Female"
            case .another:
                return "Another"
            }
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.whiteColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Geeza Pro Bold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont(name: "Helvetica", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderSegmentedControl = ExtendedSegmentedControl(first: "Male",
                                                                  second: "Female",
                                                                  third: "Another")
    private let submitButton = ExtendedButton(title: nil,
                                              backgroundColor: Colors.mainBlueColor,
                                              titleColor: .white,
                                              accessibilityIdentifier: "submitButton")
    private let closeButton = UIButton()
    private let activityView = UIActivityIndicatorView()
    
    private let usernameTextField = GBShopStandardTextField(labelText: "Name",
                                                            accessibilityIdentifier: "usernameTextField")
    private let emailTextField = GBShopStandardTextField(labelText: "Email",
                                                         accessibilityIdentifier: "emailTextField")
    private let passwordTextField = GBShopStandardTextField(labelText: "Passowrd",
                                                            isSecured: true,
                                                            accessibilityIdentifier: "passwordTextField")
    private let creditCardTextField = GBShopStandardTextField(labelText: "Credit card",
                                                              accessibilityIdentifier: "creditCardTextField")
    private let bioTextField = GBShopStandardTextField(labelText: "Bio",
                                                       accessibilityIdentifier: "bioTextField")
    
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
        setupEditorForm()
        setupDoneButton()
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
    
    private func setupEditorForm() {
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
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
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
    
    private func setupActivityView() {
        activityView.center = view.center
        activityView.color = Colors.mainBlueColor
        activityView.style = .large
        view.addSubview(activityView)
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

// MARK: - Setup targets
extension ProfileEditorViewController {
    private func addTargetToButtons() {
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    @objc func submitButtonTapped() {
        guard let username = usernameTextField.textfield.text,
              let password = passwordTextField.textfield.text,
              let email = emailTextField.textfield.text,
              let gender = SegmentControlGender.init(rawValue: genderSegmentedControl.selectedSegmentIndex)?.description,
              let creditCard = creditCardTextField.textfield.text,
              let bio = bioTextField.textfield.text,
              usernameTextField.textfield.text != "",
              passwordTextField.textfield.text != "",
              emailTextField.textfield.text != "",
              creditCardTextField.textfield.text != "",
              bioTextField.textfield.text != ""
        else {
            self.presentGBShopInfoAlert(title: "\(titleText) warning",
                                        text: "The parameters are entered incorrectly")
            return
        }
        
        let user = UserData(id: 1,
                            username: username,
                            password: password,
                            email: email,
                            gender: gender,
                            creditCard: creditCard,
                            bio: bio)
        self.startActivityViewAnimating()
        
        if isRegistration {
            sendRegistrationData(data: user)
        } else {
            sendUpdateUserData(data: user)
        }
    }
    
    private func sendRegistrationData(data: UserData) {
        let registration = requestFactory.makeRegistrationRequestFactory()
        
        registration.register(registrationData: data) { response in
            self.stopActivityAnimating()
            
            switch response.result {
            case .success(let result):
                let parametres = ["result": result.result]
                Analytics.logEvent("user registration success",
                                   parameters: parametres)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                Crashlytics.crashlytics().record(error: error)
                self.presentGBShopInfoAlert(title: "Registration warning",
                                            text: "The parameters are entered incorrectly")
            }
        }
    }
    
    private func sendUpdateUserData(data: UserData) {
        let updateUser = requestFactory.makeUpdateUserRequestFactory()
        
        updateUser.updateUser(updateUserData: data) { response in
            self.stopActivityAnimating()
            
            switch response.result {
            case .success(let result):
                let parametres = ["result": result.result]
                Analytics.logEvent("user edit success",
                                   parameters: parametres)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                Crashlytics.crashlytics().record(error: error)
                self.presentGBShopInfoAlert(title: "Edit warning",
                                            text: "The parameters are entered incorrectly")
            }
        }
    }
    
    private func presentGBShopInfoAlert(title: String, text: String) {
        DispatchQueue.main.async {
            let toVC = GBShopInfoAlert(title: title,
                                       text: text)
            toVC.modalPresentationStyle = .overCurrentContext
            toVC.modalTransitionStyle = .crossDissolve
            self.present(toVC, animated: true, completion: nil)
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
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
