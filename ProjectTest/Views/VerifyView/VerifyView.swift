//
//  VerifyView.swift
//  ProjectTest
//
//  Created by Dinar on 23.01.2025.
//

import UIKit

protocol VerifyProtocol: AnyObject {
    func verifyCode()
}

final class VerifyView: UIView {
    weak var verifyDelegate: VerifyProtocol?
    
    var verifyFields : [VerifyTextField] = []
    
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
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {self.verifyFields[0].becomeFirstResponder()}) //задержка
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func showErroro(){
//        
//    }
    
    func verifyTextFieldConfiguration() {
        for number in 0...3 {
            let textField = VerifyTextField()
            textField.tag = number
//            if number == 0 {
//                textField.becomeFirstResponder()
//            }
            textField.fieldDelegate = self
            textField.isUserInteractionEnabled = false
            verifyFields.append(textField)
            fieldsStack.addArrangedSubview(textField)
        }
        addSubview(fieldsStack)
//        verifyFields[0].becomeFirstResponder()
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
    
    func getFieldsValue() -> String {
        var fieldsValue: String = ""
        verifyFields.forEach {
            fieldsValue.append($0.text ?? "")
        }
        return fieldsValue
    }
}

extension VerifyView: FieldsProtocol {
    
    func activeNextField(tag: Int) {
        if tag != verifyFields.count - 1 {
            verifyFields[tag + 1].becomeFirstResponder()
        } else {
            verifyDelegate?.verifyCode()
        }
    }
    
    func activePrevField(tag: Int) {
        if tag != 0 {
            verifyFields[tag - 1].text = ""
            verifyFields[tag - 1].becomeFirstResponder()
        }
    }
}
