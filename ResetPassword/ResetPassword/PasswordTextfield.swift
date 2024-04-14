//
//  PasswordTextfield.swift
//  ResetPassword
//
//  Created by Alejandro Cervantes on 2024-04-11.
//

import UIKit

class PasswordTextField: UIView {
    
    let lockImage = UIImageView(image: UIImage(systemName: "lock.fill"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemOrange
        
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layout() {
        addSubview(lockImage)
        
        NSLayoutConstraint.activate([
            lockImage.topAnchor.constraint(equalTo: topAnchor),
            lockImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
