//
//  ViewController.swift
//  ResetPassword
//
//  Created by Alejandro Cervantes on 2024-04-11.
//

import UIKit

class ViewController: UIViewController {
    
    let stack = UIStackView()
    let newPasswordTextField = PasswordTextField(placeholderText: "New password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        view.backgroundColor = .systemBackground
    }
}

extension ViewController {
    
    func style() {
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        
        stack.addArrangedSubview(newPasswordTextField)
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 2)
        ])
    }
}


