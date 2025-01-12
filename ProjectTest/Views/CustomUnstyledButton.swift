//
//  CustomUnstyledButton.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//
import UIKit

final class CustomUnstyledButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .lightGray
        layer.cornerRadius = 8
        setTitleColor(.blue, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 36),
            widthAnchor.constraint(equalToConstant: 135),
        ])
    }
}
