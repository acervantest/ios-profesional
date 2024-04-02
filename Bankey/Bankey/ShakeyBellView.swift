//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by Alejandro Cervantes on 2024-03-31.
//

import Foundation
import UIKit

class ShakeyBellView: UIView {
    
    let bellImage = UIImageView()
    let badge = UIButton()
    let buttonHeight: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

extension ShakeyBellView {
    func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_: )))
        bellImage.addGestureRecognizer(singleTap)
        bellImage.isUserInteractionEnabled = true
    }
    
    func style() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        bellImage.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        bellImage.image = image
        
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.backgroundColor = .systemRed
        badge.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        badge.layer.cornerRadius = buttonHeight/2
        badge.setTitle("9", for: .normal)
        badge.setTitleColor(.white, for: .normal)
    }
    
    func layout() {
        
        addSubview(bellImage)
        addSubview(badge)
        
        // IMAGE VIEW
        NSLayoutConstraint.activate([
            bellImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bellImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            bellImage.heightAnchor.constraint(equalToConstant: 24),
            bellImage.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        // BUTTON
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: bellImage.topAnchor),
            badge.leadingAnchor.constraint(equalTo: bellImage.trailingAnchor, constant: -9),
            badge.widthAnchor.constraint(equalToConstant: 16),
            badge.heightAnchor.constraint(equalToConstant: 16)
        ])
        
    }
}

// MARK: - Actions
extension ShakeyBellView {
    @objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
        shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
    }

    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        
        bellImage.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))

        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration) {
                self.bellImage.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration) {
                self.bellImage.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2, relativeDuration: frameDuration) {
                self.bellImage.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3, relativeDuration: frameDuration) {
                self.bellImage.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4, relativeDuration: frameDuration) {
                self.bellImage.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5, relativeDuration: frameDuration) {
                self.bellImage.transform = CGAffineTransform.identity
            }
          },
          completion: nil
        )
    }
}

// https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
