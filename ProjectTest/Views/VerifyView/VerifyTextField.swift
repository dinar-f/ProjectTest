//
//  VerifyTextField.swift
//  ProjectTest
//
//  Created by Dinar on 23.01.2025.
//

import UIKit

protocol FieldsProtocol: AnyObject {
    func activeNextField(tag: Int)
    func activePrevField(tag: Int)
}

final class VerifyTextField: UITextField {
    
    weak var fieldDelegate: FieldsProtocol?
    
    // MARK: Private Properties
    private var viewState: TextFieldState = .normal {
        didSet {
            configureAppearance()
        }
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func deleteBackward() {
        fieldDelegate?.activePrevField(tag: tag)
    }
}

    // MARK: - Public Properties
extension VerifyTextField {
    enum TextFieldState {
        case normal
        case error
        case active
    }
}

    // MARK: - Private Methods
private extension VerifyTextField {
    func setupView() {
        backgroundColor = UIColor(hex: "#F5F5F5")
        font = .systemFont(ofSize: 16)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
        tintColor = .clear
        textAlignment = .center
        keyboardType = .numberPad
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            widthAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configureAppearance(){
        switch viewState {
        case .normal:
            layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
        case .error:
            layer.borderColor = UIColor(hex: "#F54545")?.cgColor
            shakeAnimation()
        case .active:
            layer.borderColor = UIColor(hex: "#196CFC")?.cgColor
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

    // MARK: - TextField Delegate
extension VerifyTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        text = string
        if range.length == 0 {
            fieldDelegate?.activeNextField(tag: tag)
            resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewState = .active
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewState = .normal
    }
}

