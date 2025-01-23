//
//  CustomUnstyledButton.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//
import UIKit

final class UnstyledButton: UIButton {
    
// MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        setupView(title)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
extension UnstyledButton {
    private func setupView(_ title: String) {
        var configuration =  UIButton.Configuration.filled()
        configuration.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration.background.backgroundColor = UIColor(hex: "#F5F5F5")
        configuration.background.cornerRadius = 8
        guard let color = UIColor(hex: "#196CFC") else { return }
        let attrString = AttributedString(
            title,
            attributes: .init([.foregroundColor: color, .font: UIFont.systemFont(ofSize: 15)])
        )
        configuration.attributedTitle = attrString
        self.configuration = configuration
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
