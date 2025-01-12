//
//  CustomTextField.swift
//  ProjectTest
//
//  Created by Dinar on 11.01.2025.
//
import UIKit

enum TextFieldType {
    case email
    case password
}

enum TextFieldState {
    case normal
    case error
    case active
}

final class CustomTextField: UITextField {
    
    var viewType: TextFieldType = .email
    private var viewState: TextFieldState = .normal {
        didSet {
            configureAppearance()
        }
    }
    let padding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    var visibilityToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.setImage(UIImage(named: "crossedEye"), for: .selected)
        button.addTarget(self, action: #selector (togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    init(type: TextFieldType) {
        super.init(frame: .zero)
        self.viewType = type
        setupView()
        setupLayout()
        configureType()
        setupImageView()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        font = .systemFont(ofSize: 16)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
    }
    
    func configureType() {
        switch viewType {
        case .password:
            isSecureTextEntry = true
            placeholder = "Пароль"
            visibilityToggleButton.isHidden = false
        case .email:
            isSecureTextEntry = false
            placeholder = "Email"
            visibilityToggleButton.isHidden = true
        }
    }
    
    func configureAppearance() {
        switch viewState {
        case .normal:
            layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
        case .error:
            layer.borderColor = UIColor(hex: "#F54545")?.cgColor
        case .active:
            layer.borderColor = UIColor(hex: "#196CFC")?.cgColor
        }
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        visibilityToggleButton.isSelected.toggle()
    }
    
    func setupImageView() {
        addSubview(visibilityToggleButton)
        visibilityToggleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visibilityToggleButton.widthAnchor.constraint(equalToConstant: 24),
            visibilityToggleButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            visibilityToggleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            widthAnchor.constraint(equalToConstant: 343),
        ])
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewState = .active
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        viewState = .normal
    }
}
