//
//  AuthorizationViewController.swift
//  ProjectTest
//
//  Created by Dinar on 11.01.2025.
//

import UIKit

class AuthorizationViewController: BaseViewController {
    
    var correctAuthValues = (email: "Qwerty123@mail.ru", password: "Qwerty123")
    var isValidValues = (email: false, password: false)
    
    private let scrollView = UIScrollView()
    private let scrollViewContent = UIView()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.text = "Войти с помощью"
        return label
    }()
    
    private let emailTextFieldErrorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Почта введена некорректно"
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextFieldErrorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Некорректный пароль"
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let mainLabel = MainLabel(title: "С возвращением!", fontSize: 22, fontWeight: .semibold)
    private let emailTextField = TextField(type: .email)
    private let passwordTextField = TextField(type: .password)
    private let informBanner = InformBanner(viewModel: .init(type: .error, title: "Некорректная почта или пароль"))
    private let passwordResetButton = UnstyledButton(title: "Забыли пароль?")
    private let loginButton = BaseButton(title: "Войти", type: .primary)
    private let samlButton = TextIconButton(iconName: "lock", title: "Войти с помощью SAML SSO")
    private let qrButton = TextIconButton(iconName: "qr", title: "Авторизация через QR")
    private let yandexButton = IconButton(iconName: "yandex")
    private let gosuslugiButton = IconButton(iconName: "gosuslugi")
    
    private let formStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let loginButtonsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let serviceButtonsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
        setupButtonTargets()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.isEnabled = false
    }
    
    func updateLoginButtonState() {
        loginButton.isEnabled = isValidValues.email && isValidValues.password
    }
    
    private func setupButtonTargets() {
        passwordResetButton.addTarget(self, action: #selector(openPasswordUpdateView), for: .touchUpInside)
        qrButton.addTarget(self, action: #selector(openQrLoginView), for: .touchUpInside)
        samlButton.addTarget(self, action: #selector(openSamlLoginView), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(authorizationCheck), for: .touchUpInside)
    }
    
    @objc func authorizationCheck() {
        loginButton.isLoading = true
        guard let enteredEmail = emailTextField.text,
              let enteredPassword = passwordTextField.text else { return }
    
        if enteredEmail == correctAuthValues.email && enteredPassword == correctAuthValues.password{
            informBanner.isHidden = true
            openVerifyViewController()
        } else {
            informBanner.isHidden = false
        }
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContent)
        scrollViewContent.addSubview(mainLabel)
        scrollViewContent.addSubview(formStackView)
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(emailTextFieldErrorLabel)
        formStackView.addArrangedSubview(passwordTextField)
        formStackView.addArrangedSubview(passwordTextFieldErrorLabel)
        formStackView.addArrangedSubview(informBanner)
        scrollViewContent.addSubview(passwordResetButton)
        scrollViewContent.addSubview(loginButton)
        scrollViewContent.addSubview(subLabel)
        scrollViewContent.addSubview(loginButtonsStackView)
        loginButtonsStackView.addArrangedSubview(samlButton)
        loginButtonsStackView.addArrangedSubview(qrButton)
        scrollViewContent.addSubview(loginButtonsStackView)
        serviceButtonsStackView.addArrangedSubview(yandexButton)
        serviceButtonsStackView.addArrangedSubview(gosuslugiButton)
        scrollViewContent.addSubview(serviceButtonsStackView)
    }
    
    func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        serviceButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mainLabel.centerXAnchor.constraint(equalTo: scrollViewContent.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 18),
            
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formStackView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            
            passwordResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordResetButton.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 24),
            
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.topAnchor.constraint(equalTo: passwordResetButton.bottomAnchor, constant: 24),
            
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            
            loginButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButtonsStackView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 24),
            
            serviceButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            serviceButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            serviceButtonsStackView.topAnchor.constraint(equalTo: loginButtonsStackView.bottomAnchor, constant: 16),
            serviceButtonsStackView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -40),
        ])
    }
}

// MARK: - Navigation Handlers
extension AuthorizationViewController {
    @objc private func openPasswordUpdateView() {
        let passwordUpdateVC = PasswordUpdateViewController()
        let navigationController = UINavigationController(rootViewController: passwordUpdateVC)
        navigationController.modalPresentationStyle = .popover
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func openQrLoginView() {
        let qrLoginVC = QrLoginViewController()
        let navigationController = UINavigationController(rootViewController: qrLoginVC)
        navigationController.modalPresentationStyle = .popover
        present(navigationController, animated: true, completion: nil)
    }
    
    private func openVerifyViewController() {
        let verifyViewController = VerifyViewController()
        navigationController?.pushViewController(verifyViewController, animated: true)
    }
    
    @objc private func openSamlLoginView() {
        let samlLoginVC = SamlLoginViewController()
        if let sheet = samlLoginVC.sheetPresentationController {
            sheet.detents = [.custom { context in
                return samlLoginVC.preferredContentSize.height
            }]
            sheet.prefersGrabberVisible = true
        }
        samlLoginVC.preferredContentSize = CGSize(width: view.bounds.width, height: 300)
        present(samlLoginVC, animated: true, completion: nil)
    }
}

// MARK: - TextField Delegate
extension AuthorizationViewController: UITextFieldDelegate {
    
    func validateTextField(_ textField: UITextField, validationPattern: String, errorLabel: UILabel) -> Bool{
        guard let text = textField.text else {
            return false
        }
        let format = "SELF MATCHES %@"
        let isValid = NSPredicate(format: format, validationPattern).evaluate(with: text)
        errorLabel.isHidden = isValid
        return isValid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailTextField.viewState = .active
        case passwordTextField:
            passwordTextField.viewState = .active
        default: break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            isValidValues.email = validateTextField(textField,
                                                    validationPattern: "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,4}",
                                                    errorLabel: emailTextFieldErrorLabel)
            emailTextField.viewState = isValidValues.email ? .normal : .error
            updateLoginButtonState()
        case passwordTextField:
            isValidValues.password = validateTextField(textField,
                                                       validationPattern: "^(?=.*[A-Z])(?=.*\\d).{8,}$",
                                                       errorLabel: passwordTextFieldErrorLabel)
            passwordTextField.viewState = isValidValues.password ? .normal : .error
            updateLoginButtonState()
        default: break
        }
    }
}
