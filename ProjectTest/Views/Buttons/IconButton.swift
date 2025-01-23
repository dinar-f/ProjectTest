//
//  CustomIocnButton.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//

import UIKit

final class IconButton: UIButton {
    
    var isLoading = false {
        didSet {
            updateView()
        }
    }
    
// MARK: Private Properties
    private let iconView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    private let spinner = SpinnerLoader(color: .red, size: .small)
        
    // MARK: - Init
    init(iconName: String) {
        super.init(frame: .zero)
        setupView(iconName: iconName)
        setupLayout()
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchBegan()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEnded()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchEnded()
    }
}

// MARK: - Private Methods
extension IconButton {
    private func setupView(iconName: String) {
        backgroundColor = .white
        iconView.image = UIImage(named: iconName)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    private func updateView() {
        if isLoading {
            addSubview(spinner)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        } else {
            addSubview(iconView)
            iconView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                iconView.widthAnchor.constraint(equalToConstant: 24),
                iconView.heightAnchor.constraint(equalToConstant: 24),
                iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        }
    }
    
    private func touchBegan() {
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.allowUserInteraction, .curveEaseOut]
        ) {
            self.transform = .init(scaleX: 0.96, y: 0.96)
        }
    }
    
    private func touchEnded() {
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.allowUserInteraction, .curveEaseOut]
        ) {
            self.transform = .identity
        }
    }
}
