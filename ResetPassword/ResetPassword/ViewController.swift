//
//  ViewController.swift
//  ResetPassword
//
//  Created by Alejandro Cervantes on 2024-04-11.
//

import UIKit

class ViewController: UIViewController {
    
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
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layout() {
        
        view.addSubview(newPasswordTextField)
        
        NSLayoutConstraint.activate([
            newPasswordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: newPasswordTextField.trailingAnchor, multiplier: 1),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


