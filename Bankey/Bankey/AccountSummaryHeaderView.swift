//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Alejandro Cervantes on 2024-03-18.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    let shakeyBellView = ShakeyBellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        setupShakeyBell()
    }
    
    private func setupShakeyBell() {
        
        addSubview(shakeyBellView)
        
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shakeyBellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shakeyBellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
