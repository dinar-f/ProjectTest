//
//  BaseButton.swift
//  ProjectTest
//
//  Created by Dinar on 12.01.2025.
//

import UIKit

final class BaseButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            updateBackground()
        }
    }
    
    var isLoading = true {
        didSet {
            updateView()
        }
    }
    
    // MARK: Private Properties
    private let spinner = SpinnerLoader(color: .white, size: .small)
    
    
    // MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        self.isEnabled = true
        setTitle(title, for: .normal)
        setupView()
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
private extension BaseButton {
    func setupView() {
        layer.cornerRadius = 12
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    func updateBackground() {
        if isEnabled {
            backgroundColor = UIColor(hex: "#196CFC")
        } else {
            setTitleColor(UIColor(hex: "#C0C0C0"), for: .disabled)
            backgroundColor = UIColor(hex: "#F0F0F0")
        }
    }
    
    func updateView(){
        setTitle(nil, for: .normal)
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func touchBegan() {
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.allowUserInteraction, .curveEaseOut]
        ) {
            self.transform = .init(scaleX: 0.98, y: 0.98)
        }
    }
    
    func touchEnded() {
        UIView.animate(
            withDuration: 0.1,
            delay: .zero,
            options: [.allowUserInteraction, .curveEaseOut]
        ) {
            self.transform = .identity
        }
    }
}


