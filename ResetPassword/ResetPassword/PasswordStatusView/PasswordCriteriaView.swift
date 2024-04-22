//
//  PasswordCriteriaView.swift
//  ResetPassword
//
//  Created by Alejandro Cervantes on 2024-04-14.
//

import UIKit

class PasswordCriteriaView: UIView {
    
    let stack = UIStackView()
    let image = UIImageView()
    let label = UILabel()
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        
    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                image.image = checkmarkImage
            } else {
                image.image = xmarkImage
            }
        }
    }
    
    func reset() {
        isCriteriaMet = false
        image.image = circleImage
    }
    
    init(text: String) {
        super.init(frame: .zero)
        
        label.text = text
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 40)
    }
}

extension PasswordCriteriaView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "circle")?.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
    }
    
    func layout() {
        
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(label)
        
        addSubview(stack)
        
        // Stack
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Image View
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalTo: image.widthAnchor)
        ])
        
        // CHCR
        image.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
}

//MARK: - Tests
extension PasswordCriteriaView {
    var isCheckMarkImage: Bool {
        return image.image == checkmarkImage
    }
    
    var isXMarkImage: Bool {
        return image.image == xmarkImage
    }
    
    var isResetImage: Bool {
        return image.image == circleImage
    }
}
