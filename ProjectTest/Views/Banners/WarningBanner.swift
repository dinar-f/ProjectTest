//
//  WarningBanner.swift
//  ProjectTest
//
//  Created by Dinar on 19.01.2025.
//

import UIKit

final class WarningBanner: UIView {
    
    private var buttonHandler: (() -> Void)?
    
// MARK: Private Properties
    private let iconView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Повторить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
// MARK: - Init
    init(title: String, action: @escaping (() -> Void)) {
        super.init(frame: .zero)
        self.buttonHandler = action
        addSubviews()
        setupView(title: title)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        if let action = buttonHandler {
            action()
            close()
        }
    }
    
    func show(in view: UIView) {
        alpha = 0
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
        ])
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.center.y = 50
        }
    }
    
    func close() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

// MARK: - Private Methods
private extension WarningBanner {
    func addSubviews() {
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(mainButton)
    }
    
    func setupView(title: String) {
        layer.cornerRadius = 12
        layer.borderWidth = 1
        backgroundColor = UIColor(hex: "#191919")
        iconView.image = UIImage(named: "redAlert")
        titleLabel.text = title
     }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: mainButton.leadingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            mainButton.widthAnchor.constraint(equalToConstant: 74),
            mainButton.heightAnchor.constraint(equalToConstant: 20),
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
