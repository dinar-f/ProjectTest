//
//  CustomPrimaryButton.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//

import UIKit

final class CustomPrimaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupView(title: title)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(title: String) {
        backgroundColor = .blue
        layer.cornerRadius = 12
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            widthAnchor.constraint(equalToConstant: 343),
        ])
    }
    
}
