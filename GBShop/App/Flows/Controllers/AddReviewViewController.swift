//
//  TestViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 10.10.2021.
//

import UIKit

class AddReviewViewController: UIViewController {
    var interactiveAnimator = UIViewPropertyAnimator()
    var shouldDismissController: Bool = false
    
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateAppearanceContainerView()
    }
}

//MARK: - Setup views
extension AddReviewViewController {
    private func setupViews() {
        view.backgroundColor = .clear
        setupContainerView()
        addTargets()
    }
    
    private func setupContainerView() {
        containerView.alpha = 0
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.backgroundColor = .red
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

//MARK: - Setup targets
extension AddReviewViewController {
    private func addTargets() {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: .greatestFiniteMagnitude, animations: {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: self.containerView.frame.height)
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
}
