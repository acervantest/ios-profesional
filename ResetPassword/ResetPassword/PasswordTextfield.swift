//
//  PasswordTextfield.swift
//  ResetPassword
//
//  Created by Alejandro Cervantes on 2024-04-11.
//

import UIKit

class PasswordTextField: UIView {
    
    let lockImage = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let placeHolderText: String
    let eyeButton = UIButton(type: .custom)
    let divider = UIView()
    let errorMessage = UILabel()
    
    init (placeholderText: String) {
        
        self.placeHolderText = placeholderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false // true
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .separator
        
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.font = .preferredFont(forTextStyle: .footnote)
        errorMessage.textColor = .systemRed
        errorMessage.text = "Your password must meet the requirements below."
        errorMessage.numberOfLines = 0
        errorMessage.lineBreakMode = .byWordWrapping
        errorMessage.isHidden = false
        // errorMessage.adjustsFontSizeToFitWidth = true
        // errorMessage.minimumScaleFactor = 0.8
    }
    
    func layout() {
        
        addSubview(lockImage)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(divider)
        addSubview(errorMessage)
        
        // Lock
        NSLayoutConstraint.activate([
            lockImage.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        // Textfield
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImage.trailingAnchor, multiplier: 1)
        ])
        
        // Eye
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Divider
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Error Label
        NSLayoutConstraint.activate([
            errorMessage.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorMessage.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 4)
        ])
        
        // CHCR
        lockImage.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}


// MARK: - Actions
extension PasswordTextField {
    @objc func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}

// MARK: - UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate {
    
    // Loss of focus
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("foo - textFieldDidEndEditing: \(textField.text!)")
    }

    // Called when 'return' key pressed. Necessary for dismissing keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("foo - textFieldShouldReturn")
        textField.endEditing(true) // resign first responder
        return true
    }
}
