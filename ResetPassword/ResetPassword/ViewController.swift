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
    let passwordStatus = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeholderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        view.backgroundColor = .systemBackground
    }
}

extension ViewController {
    
    func setup() {
        setupNewPassword()
        setupDismissKeyboardGesture()
    }
    
    private func setupNewPassword() {
        
        let newPasswordValidation: CustomValidation = { text in
            // Empty text validation
            guard let text = text, !text.isEmpty else {
                self.passwordStatus.reset()
                return (false, "Enter your password")
            }
            return(true, "")
        }
        
        newPasswordTextField.customValidation = newPasswordValidation
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    func style() {
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.delegate = self
        
        passwordStatus.translatesAutoresizingMaskIntoConstraints = false
        passwordStatus.layer.cornerRadius = 5
        passwordStatus.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.delegate = self

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        // resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        
        stack.addArrangedSubview(newPasswordTextField)
        stack.addArrangedSubview(passwordStatus)
        stack.addArrangedSubview(confirmPasswordTextField)
        stack.addArrangedSubview(resetButton)
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 2)
        ])
    }
}

// MARK: - actions
extension ViewController {
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true) // resign first responder
    }
}

// MARK: - text field delegate
extension ViewController: PasswordTextFieldDelegate {
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            _ = newPasswordTextField.validate()
        }
    }
}
