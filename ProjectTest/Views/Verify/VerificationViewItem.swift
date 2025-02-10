//
//  VerificationViewItem.swift
//  ProjectTest
//
//  Created by Dinar on 29.01.2025.
//
import UIKit


final class VerificationViewItem: UIView {
    
    var viewState: VerificationViewItemState = .initial {
        didSet {
            configureAppearance()
        }
    }

    private let dotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "•"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(hex: "#F5F5F5")
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
        tintColor = .clear
        addSubview(dotLabel)
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        dotLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            widthAnchor.constraint(equalToConstant: 44),
            dotLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dotLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func configureAppearance(){
        switch viewState {
        case .initial:
            layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
            dotLabel.textColor = .lightGray
        case .filled:
            layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
            dotLabel.textColor = .black
        case .error:
            layer.borderColor = UIColor(hex: "#F54545")?.cgColor
            dotLabel.textColor = .black
            shakeAnimation()
        case .active:
            layer.borderColor = UIColor(hex: "#196CFC")?.cgColor
            dotLabel.textColor = .lightGray
        }
    }
    
    func shakeAnimation() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 1
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 3, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 3, y: self.center.y))
    
        self.layer.add(shake, forKey: "position")
    }
}

extension VerificationViewItem {
    enum VerificationViewItemState {
        case initial
        case filled
        case active
        case error
    }
}
