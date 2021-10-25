//
//  TestViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 10.10.2021.
//

import UIKit

class AddReviewViewController: UIViewController {
    private let requestFactory = RequestFactory()
    
    private var interactiveAnimator = UIViewPropertyAnimator()
    private var shouldDismissController: Bool = false
    private var isKeyboardShown = false
    
    private let containerView = UIView()
    private let reviewTextView = UITextView()
    private let addButton = ExtendedButton(title: "add",
                                           backgroundColor: Colors.mainBlueColor,
                                           titleColor: Colors.whiteColor)
    
    var onCompletion: ((AllReviewsResult) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateAppearanceContainerView()
    }
    
    private func postReview(with text: String) {
        let addReview = requestFactory.makeAddReviewRequestFactory()
        addReview.getAddReview(idUser: 123, text: text) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Setup views
extension AddReviewViewController {
    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setupContainerView()
        setupReviewTextView()
        setupAddButton()
        addGestures()
    }
    
    private func setupContainerView() {
        containerView.alpha = 0
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.backgroundColor = Colors.whiteColor
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupReviewTextView() {
        reviewTextView.layer.cornerRadius = 10
        reviewTextView.backgroundColor = #colorLiteral(red: 0.9016370177, green: 0.9304099083, blue: 0.9283030629, alpha: 1)
        reviewTextView.layer.borderWidth = 0.2
        containerView.addSubview(reviewTextView)
        
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reviewTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            reviewTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            reviewTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            reviewTextView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupAddButton() {
        containerView.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 30),
            addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func animateAppearanceContainerView() {
        containerView.transform = .init(translationX: 0, y: containerView.frame.height)
        containerView.alpha = 1
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
    }
}

//MARK: - Setup observers and gestures
extension AddReviewViewController {
    private func addGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))

        view.addGestureRecognizer(tapRecognizer)
        view.addGestureRecognizer(panRecognizer)
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
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        guard !isKeyboardShown else { return }
        switch recognizer.state {
        case .began:
            interactiveAnimator.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: .greatestFiniteMagnitude,
                                                         animations: {
                self.containerView.transform = CGAffineTransform(translationX: 0,
                                                                 y: self.containerView.frame.height)
            })
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 300
            let relativeTranslation = translation.y / (view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            self.shouldDismissController = progress > 0.35
        case .ended:
            if shouldDismissController {
                interactiveAnimator.stopAnimation(true)
                UIView.animate(withDuration: 0.2) {
                    self.containerView.transform = .init(translationX: 0, y: self.containerView.frame.height)
                } completion: { _ in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                interactiveAnimator.addAnimations {
                    self.containerView.transform = .identity
                }
                interactiveAnimator.startAnimation()
            }
        default:
            return
        }
    }
    
    @objc private func keyboardWillBeShown(notification: Notification) {
        guard !isKeyboardShown else { return }
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        if let kbHeight = keyboardSize?.height {
            self.containerView.transform = .init(translationX: 0, y: -kbHeight)
        }
        isKeyboardShown = true
    }
    
    @objc private func keyboardWillBeHiden() {
        guard isKeyboardShown else { return }
        
        self.containerView.transform = .identity
        isKeyboardShown = false
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Setup targets
extension AddReviewViewController {
    private func addTarget() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        let review = AllReviewsResult(idReview: 0,
                                      idProduct: 0,
                                      text: reviewTextView.text,
                                      user: User(id: 0,
                                                 login: "Sergey",
                                                 name: "Sergey",
                                                 lastname: "Sergeev"))
        onCompletion?(review)
        postReview(with: reviewTextView.text)
        if !isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.containerView.transform = .init(translationX: 0, y: self.containerView.frame.height)
            } completion: { _ in
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
