//
//  TestViewController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 05.10.2021.
//

import UIKit

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let button = ExtendedButton(title: "hello", backgroundColor: Colors.whiteColor, titleColor: .black, isShadow: true)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
