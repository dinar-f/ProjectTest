//
//  TextFieldView.swift
//  ProjectTest
//
//  Created by Dinar on 27.01.2025.
//

import UIKit

final class TextFieldView: UIView {
    
    private var viewType: TextFieldType = .email
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hex: "#F5F5F5")
        textField.font = .systemFont(ofSize: 16)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
        return textField
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#F54545")
        label.text = "Неверный формат"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    init(type: TextFieldType) {
        super.init(frame: .zero)
        self.viewType = type
        addSubviews()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        textFieldStackView.addArrangedSubview(textField)
        textFieldStackView.addArrangedSubview(errorLabel)
        addSubview(textFieldStackView)
        layer.borderColor = UIColor(hex: "#F54545")?.cgColor
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            textFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldStackView.topAnchor.constraint(equalTo: topAnchor),
            textFieldStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}


// MARK: - Public Properties
extension TextFieldView {
    enum TextFieldType {
        case email
        case password
        case domain
    }

    enum TextFieldState {
        case normal
        case error
        case active
    }
}


