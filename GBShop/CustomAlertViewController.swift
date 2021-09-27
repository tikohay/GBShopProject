//
//  CustomAlertViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 27.09.2021.
//

import UIKit

class CustomAlertViewController: UIViewController {
    var blurView = UIVisualEffectView()
    let alertView = UIView()
    
    var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlurView()
        setupAlertView()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurView = UIVisualEffectView(effect: blur)
        
        view.addSubview(blurView)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAlertView() {
        blurView.contentView.addSubview(alertView)
        
        alertView.backgroundColor = .red
        alertView.layer.cornerRadius = 15
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            alertView.heightAnchor.constraint(equalToConstant: 300),
            alertView.widthAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    private func addGestures() {
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(dismissToMainVC))
        view.addGestureRecognizer(tapViewGesture)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHiden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissToMainVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        isKeyboardShown.toggle()
        
        let info = notification.userInfo as NSDictionary?
        
        guard let kbSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size else { return }
        
        self.alertView.transform = CGAffineTransform(translationX: 0, y: -kbSize.height + 120)
    }
    
    @objc func keyboardWillBeHiden() {
        isKeyboardShown.toggle()
        self.alertView.transform = .identity
    }
}
