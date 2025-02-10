//
//  Untitled.swift
//  ProjectTest
//
//  Created by Dinar on 29.01.2025.
//

import UIKit

final class VerificationView: UIView {
    
    var verifyFields : [VerificationViewItem] = []
    
    private let fieldsStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        verifyTextFieldConfiguration()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func verifyTextFieldConfiguration() {
        for number in 0...3 {
            let verifyItem = VerificationViewItem()
            verifyItem.tag = number
            verifyFields.append(verifyItem)
            fieldsStack.addArrangedSubview(verifyItem)
        }
        addSubview(fieldsStack)
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            fieldsStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            fieldsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            fieldsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            fieldsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }
}
