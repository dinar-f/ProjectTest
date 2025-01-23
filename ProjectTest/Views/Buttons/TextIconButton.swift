//
//  TextIconButton.swift
//  ProjectTest
//
//  Created by Dinar on 18.01.2025.
//

import UIKit

protocol TextIconButtonProtocol: UIButton {
    func setTitle(_ title: String)
    func configuer(with viewModel: TextIconButton.ViewModel)
}

final class TextIconButton: UIButton {
    
// MARK: Private Properties
    private let iconView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
// MARK: - Init
    init(iconName: String, title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
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

extension TextIconButton: TextIconButtonProtocol {
    func configuer(with viewModel: ViewModel) {
        setTitle(viewModel.title, for: .normal)
        setupView(iconName: viewModel.imageName)
    }
    
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
        
    }
}

// MARK: - Private Methods
extension TextIconButton {
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
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        if let titleLabel = titleLabel {
            NSLayoutConstraint.activate([
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
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

extension TextIconButton {
    enum ButtonType {
        case saml
        case qrCode
    }
    
    struct ViewModel {
        let title: String
        let imageName: String
    }
}
