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
        setupConfirmPassword()
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
    }
    
    private func setupNewPassword() {
        
        let newPasswordValidation: CustomValidation = { text in
            
            // Empty text validation
            guard let text = text, !text.isEmpty else {
                self.passwordStatus.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.passwordStatus.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            // Criteria met
            self.passwordStatus.updateDisplay(text)
            
            if !self.passwordStatus.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            return(true, "")
        } 
        
        newPasswordTextField.customValidation = newPasswordValidation
        newPasswordTextField.delegate = self
    }
    
    private func setupConfirmPassword() {
        
        let confirmPasswordValidation: CustomValidation = { text in
            
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password")
            }
            
            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match")
            }
            
            return (true, "")
        }
        
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func style() {
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordStatus.translatesAutoresizingMaskIntoConstraints = false
        passwordStatus.layer.cornerRadius = 5
        passwordStatus.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false

        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
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

// MARK: - Keyboard
extension ViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        //print("foo - userInfo: \(userInfo) - keyboardFrame: \(keyboardFrame) - currentTextField: \(currentTextField)")
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
            //print("foo - Adjust View!")
        }

        //print("foo - currentTextFieldFrame: \(currentTextField.frame) - convertedTextFieldFrame: \(convertedTextFieldFrame)")
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

// MARK: - actions
extension ViewController {
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true) // resign first responder
    }
    
    @objc func resetPasswordButtonTapped(sender: UIButton) {
        view.endEditing(true)
        
        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()
        
        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - text field delegate
extension ViewController: PasswordTextFieldDelegate {
    
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            passwordStatus.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            // as soon as we lose focus, make ❌ appear
            passwordStatus.shouldResetCriteria = false
            _ = newPasswordTextField.validate()
        } else if sender === confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
}

// MARK: - Tests
extension ViewController {
    var newPasswordText: String? {
        get { return newPasswordTextField.text }
        set { newPasswordTextField.text = newValue }
    }
    
    var confirmPasswordText: String? {
        get { return confirmPasswordTextField.text }
        set { confirmPasswordTextField.text = newValue }
    }
}
