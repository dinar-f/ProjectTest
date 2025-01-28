//
//  TextField.swift
//  ProjectTest
//
//  Created by Dinar on 18.01.2025.
//
import UIKit

protocol TextFieldProtocol: AnyObject {
    func check()
}

final class TextField: UITextField {
    
    weak var textFieldDelegate: TextFieldProtocol?
    
    override var isSecureTextEntry: Bool {
        didSet {
            imageview.image = isSecureTextEntry
            ? UIImage(named: "eye")
            : UIImage(named: "crossedEye")
        }
    }
    
    var isValid = false
    
    // MARK: Private Properties
    private var viewType: TextFieldType = .email
    
    var viewState: TextFieldState = .normal {
        didSet {
            configureAppearance()
        }
    }
    
    private let imageview: UIImageView = {
        let imageview = UIImageView()
        imageview.isUserInteractionEnabled = true
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#F54545")
        label.text = "Неверный формат"
        label.font = .systemFont(ofSize: 13)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Init
    init(type: TextFieldType) {
        super.init(frame: .zero)
        self.viewType = type
        setupView()
        configureAppearance()
        configureType()
        setupLayout()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let width: CGFloat = 24
        let height: CGFloat = bounds.height
        let adjustedX = bounds.width - width - 16
        return CGRect(x: adjustedX, y: (bounds.height - height) / 2, width: width, height: height)
    }
}

extension TextField: UITextFieldDelegate  {
    
    func validateTextField(_ textField: UITextField, validationPattern: String){
        guard let text = textField.text else {
            return
        }
        let format = "SELF MATCHES %@"
        let isValueValid = NSPredicate(format: format, validationPattern).evaluate(
            with: text
        )
        viewState = isValueValid ? .normal : .error
        isValid = isValueValid
        textFieldDelegate?.check()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewState = .active
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch viewType {
        case .email:
            validateTextField(textField,
                              validationPattern: "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,4}")
        case .password:
            validateTextField(textField,
                              validationPattern: "^(?=.*[A-Z])(?=.*\\d).{8,}$")
        default: break
        }
    }
}

// MARK: - Public Properties
extension TextField {
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

    // MARK: - Private Methods
extension TextField {
    @objc func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
    }
    
    private func setupView() {
        backgroundColor = UIColor(hex: "#F5F5F5")
        font = .systemFont(ofSize: 16)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
        addSubview(errorLabel)
        imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility)))
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            
            errorLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        ])
    }
    
    private func configureAppearance(){
        switch viewState {
        case .normal:
            layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
        case .error:
            layer.borderColor = UIColor(hex: "#F54545")?.cgColor
        case .active:
            layer.borderColor = UIColor(hex: "#196CFC")?.cgColor
        }
    }
    
    private func configureType() {
        switch viewType {
        case .password:
            isSecureTextEntry = true
            placeholder = "Пароль"
            rightView = imageview
            rightViewMode = .always
        case .email:
            isSecureTextEntry = false
            placeholder = "Email"
        case .domain:
            isSecureTextEntry = false
            placeholder = "Рабочий домен"
        }
    }
}

