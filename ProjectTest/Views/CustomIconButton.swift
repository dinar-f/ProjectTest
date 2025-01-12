//
//  CustomIocnButton.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//

import UIKit

final class CustomIconButton: UIButton {
    
    private let iconView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()

    init(iconName: String, title: String? = nil) {
        super.init(frame: .zero)
        setupView(iconName: iconName)
        setupLayout()
        setupIconView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIconView() {
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func setupView(iconName: String) {
        backgroundColor = .white
        iconView.image = UIImage(named: iconName)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            widthAnchor.constraint(equalToConstant: 165.5),
        ])
    }

}
